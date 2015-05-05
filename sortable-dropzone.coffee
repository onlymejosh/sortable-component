`import Ember from 'ember'`

SortableDropzoneComponent = Ember.Component.extend
  classNames: ['sortable-dropzone']
  classNameBindings: ['dragClass']
  dragClass: 'inactive'
  accepts: 'text/plain'
  identifier: null

  _item: null

  ###
    EVENTS
  ###
  dragLeave: (e) ->
    e.preventDefault()
    @set('dragClass', 'inactive')

  dragOver: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @set('dragClass', 'active')
    placeholder = @get('placeholder')
    $target = $(e.target)
    if e.target.className == placeholder.className
      return
    else if $target.hasClass('sortable-dropzone')
      $(e.target).append(placeholder)
    else if e.originalEvent.dataTransfer.types.contains("#{@get('accepts')}")
      $elem = $target
      $elem = $elem.closest('.sortable-element')
      @set '_item', $elem
      if $elem.length > 0
        relY = e.originalEvent.pageY - $elem.offset().top
        height = $elem.height() * 0.5
        parent = $elem.parent()[0]
        if parent
          # Decide if the placeholder is above or below the closed element
          if(relY > height) 
            parent.insertBefore(placeholder, $elem.next()[0])
          else if(relY < height) 
            parent.insertBefore(placeholder, $elem[0])

  drop: (e) ->
    e.preventDefault()
    $(@get('placeholder')).remove()

    data = e.dataTransfer.getData('text/plain')
    data = JSON.parse(data)
    data.destination = @get('identifier')
    
    $target = @get('_item')
    if $target and $target.length > 0
      target_y = $target.offset().top
      relative_y = e.originalEvent.pageY - target_y
      # We need to check to see whether the item should be place
       # above or below the target. To do this we use the targets height + a tolernace of 0.5
      relative_height = $target.height()*0.5
      relative_pos = if relative_y > relative_height then 'below' else 'above'
      data.order = relative_pos
      data.item  = $target.attr('content')
    else
      data.order = 'below'
    @set('dragClass', 'inactive')
    @sendAction('dropped', data, e)

`export default SortableDropzoneComponent`
