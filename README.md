# Sortable Dropzone Compontent

An [Ember](http://emberjs.com) component for implementing HTML5 Drag and Drop.

## How to Use

There are two parts to supporting Drag and Drop. The first is the dropzone. Which is implemented like so:


## sortable-dropzone
```
{{#sortable-dropzone dropped="changeState" identifier="todo" accepts="*"}}

{{/sortable-dropzone}}
```

It takes the following options:
* `dropped` This action is called once an item has been dropped into the container
* `identifier` The destination in which is being dropped into
* `placeholder` A placeholder element which is inserted when hovering
* `accepts` Fine-grain control on what can be dropped in the container. [See here from more details](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Drag_operations#dragdata)

## sortable-element
```
{{#sortable-element content=ticket.id type="ticket" origin="todo"}}
  <div class="task-ticket">
    <div class="ticket-title">
      {{ticket.title}}
    </div>
    <span class="ticket-number">
      #{{ticket.local_id}}
    </span>
  </div>
{{/sortable-element}}
```

It takes the following options:
* `content` The identifier of the item being moved. 
* `type` sortable-dropzone and sortable-elements can be nested if that is the case pass a type.
* `origin` The dropzone the item belongs to.

## Take me to the demo already!
[Here you go]()
