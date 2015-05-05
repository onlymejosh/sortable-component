`import Ember from 'ember'`

SortableElementComponent = Ember.Component.extend
  classNames: ['sortable-element']
  attributeBindings: ['draggable', 'content']
  classNameBindings: ['dragClass']
  draggable: 'true'
  dragClass: 'idle'
  group: null
  type: null
  origin: null

  dragData: null

  dragged: null
  placeholder: null
  
  ###
    EVENTS
  ###
  dragStart: (e) ->
    e.stopPropagation()
    data = {}
    
    draggedChildren = $(e.target).find('.sortable-element')
    data.children = []
    if draggedChildren.length > 0
      draggedChildren.each (i, child) ->
        data.children.push($(child).attr('content'))
    
    @set('dragged', e.target)
    @set('dragClass', 'dragging')

    data.content = @get('content')
    data.group = @get('group')
    data.type = @get('type')
    data.origin = @get('origin')
    
    e.dataTransfer.setData('text/plain', JSON.stringify(data))
    e.dataTransfer.setData("dnd/#{@get('group')}", null)

  dragOver: ->
    dragged = @get('dragged')
    if dragged?
      dragged.style.display = 'none'

  dragEnd: (e) ->
    dragged = @get('dragged')
    if dragged?
      $('.sortable-placeholder').remove()
      @get('dragged').style.display = 'block'
      @set('dragged', null)

  # this sets the 'result' field in the event
  drop: (e) ->
    @set('dragClass', 'idle')

`export default SortableElementComponent`
