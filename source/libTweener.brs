function tweener(object)

    object.tweenList = {}
    object._min_dt = 10
    object._max_dt = 0
    '===========================================================================
    'game object
    '===========================================================================
    object.onCreate = function(args)
        m.Append(args)
        m.game.tweenID = 0
    end function

    object.onUpdate = function(dt)
        m._min_dt = MIN(dt,m._min_dt)
        m._max_dt = MAX(dt,m._max_dt)

        completeList = []
        for each key in m.tweenList
            item =  m.tweenList[key]
            if NOT item.isComplete()
                item.update(dt)
            else
                completeList.Push(key)
                item.Clear()
            end if  
        end for
        for each old_key in completeList
            m.tweenList.Delete(old_key)
        end for
    end function
    '===========================================================================
    'public
    '===========================================================================
    object.addTween = function(pTween as Object)
        m.tweenList[pTween.id] = pTween
    end function

    object.stopTween = function(pTweenID as string)
        if m.tweenList.DoesExist(pTweenID)
            instance = m.tweenList[pTweenID]
            m.tweenList.Delete(pTweenID)
			instance.Clear()
			instance.id = invalid
        end if
    end function

    object.stopAllForTarget = function(pTarget as Dynamic)
        stopList = []
        for each key in m.tweenList
            item =  m.tweenList[key]
            if item.Count() > 0 AND item.target.id = pTarget.id
                stopList.Push(key)
                item.Clear()
            end if  
        end for
        for each old_key in stopList
            m.tweenList.Delete(old_key)
        end for
    end function

    object.hasActiveTweens = function (pTarget as Dynamic) as boolean
        for each key in m.tweenList
            item =  m.tweenList[key]
            if item.Count()>0 AND item.target.id = pTarget.id AND NOT item.isComplete()
                return true
            end if  
        end for
        return false
    end function

    object.hasActiveTween = function (pID as string) as boolean
        for each key in m.tweenList
            if key = pID
                return true
            end if  
        end for
        return false
    end function

    object.getActiveTweenCount = function() as integer
        return m.tweenList.Count()
    end function
    '===========================================================================
    'private
    '===========================================================================


end function
'================Interfaces===============================================
Function ITweenItem(obj as object) as object
    'm.tweenID = m.tweenID + 1
    m.game.tweenID = m.game.tweenID + 1
    
    this = {
        'public
        id:m.game.tweenID.ToStr()
        target:obj

        run:  function() as string
            globalm = GetGlobalAA() 
            globalm.game.tweener.addTween(m)
            return m.id
        end function

        update: function(dt)
            m.execute()
        end function

        isComplete : function() as boolean
            return m.pWasExecuted
        end function

        'protected
        pWasExecuted:false

        execute: function()
            m.pWasExecuted = true
        end function

        getDuration: function() as integer
            return 0
        end function

        reset: function()
        end function
    }
    return this
end Function

Function ITweenFiniteTime(obj as object,data as object,pDuration as integer,tween = "LinearTween") as object
    this = ITweenItem(obj)
    this.Append({
        start: {}
        dest: {}
        duration: pDuration
        elapsed: 0
        tween_data:data
        tween:tween
        tweens:GetTweens()

        getDuration: function() as integer
            return m.duration
        end function

        makeStep: function() 
            for each key in m.start
                m.target[key] = m.tweens[m.tween](m.start[key], m.dest[key], m.elapsed, m.duration)
            end for
        end function

        'override
        update: function(dt)
            if m.elapsed = 0 then m._init()

            m.makeStep()
            if m.elapsed < m.duration
                m.elapsed+=dt*1000
                m.elapsed = MIN(m.elapsed,m.duration)
            else
                m.execute()
            end if
        end function

        _init:function()
            for each key in m.tween_data
                m.start[key] = m.target[key]
            end for
        end function

        reset: function()
            m.pWasExecuted = false
            m.elapsed = 0
        end function
    })
    
    for each key in data
        this.start[key] = obj[key]
        this.dest[key] = data[key]
    end for

    return this
end Function
'===========================================================================
'tween types
'===========================================================================
Function OffsetTo(obj as object, px as integer, py as integer, tDuration,tween = "LinearTween") as object
    this = ITweenFiniteTime(obj,{offset_x:px,offset_y:py},tDuration,tween)

    return this
end Function

'****************************************************************************
Function MoveTo(obj as object, px as integer, py as integer, tDuration,tween = "LinearTween") as object
    this = ITweenFiniteTime(obj,{x:px,y:py},tDuration,tween)

    return this
end Function

'****************************************************************************
Function CallFunc(obj as object, params as object,func as function) as object
    this = ITweenItem(obj)
    this.f_obj = func
    this.params = params
    this.execute = function()
        m.pWasExecuted = true
        m.f_obj(m.target,m.params)
    end function
    return this
end Function

'****************************************************************************
Function DelayTime(obj as object, tDuration) as object
    this =  ITweenFiniteTime(obj,{},tDuration)
    return this
end Function
'****************************************************************************
Function Sequence(obj as object) as object
    this =  ITweenFiniteTime(obj,{},0)
    this.actionList = []

    this.addAction = function(act as object) as boolean
        if m.elapsed = 0
            m.actionList.Push(act)
            return true
        end if
        return false
    end function

    this.update = function(dt)
        m.elapsed+=dt*1000
        for i=0 to m.actionList.Count()-1
            worker = m.actionList[i]
            if NOT worker.isComplete() 
                worker.update(dt)
                return true
            end if
        end for
        m.execute()
    end function

    this.isComplete = function() as boolean
        for i=0 to m.actionList.Count()-1
            worker = m.actionList[i]
            if NOT worker.isComplete() return false
        end for
        return true
    end function

    this.getDuration = function() as integer
        ret = 0
        for i=0 to m.actionList.Count()-1
            ret += m.actionList[i].getDuration()
        end for
        return ret
    end function

    this.reset = function()
        for i=0 to m.actionList.Count()-1
            m.actionList[i].reset()
        end for
    end function

    return this
end Function
'****************************************************************************
Function LoopAction(obj as object,act as object) as object
    this =  ITweenFiniteTime(obj,{},0)
    this.worker = act

    this.update = function(dt)
        m.elapsed+=dt*1000
        if NOT m.worker.isComplete() 
            m.worker.update(dt)
            return true
        end if
        m.execute()
    end function

    this.execute = function()
        m.worker.reset()
    end function

    this.isComplete = function() as boolean
        'if NOT m.worker.isComplete() return false

        return false
    end function

    this.getDuration = function() as integer
        return m.worker.getDuration()
    end function

    return this
end Function


'****************************************************************************
'****************************************************************************
Function MAX(a,b)
    if a >= b
        return a
    end if
    return b
End Function

Function MIN(a,b)
    if a < b
        return a
    end if
    return b
End Function