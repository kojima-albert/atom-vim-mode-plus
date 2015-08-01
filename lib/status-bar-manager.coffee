{Disposable, CompositeDisposable} = require 'atom'

ContentsByMode =
  'insert':               ["insert", "Insert"]
  'insert.replace':       ["insert", "Replace"]
  'normal':               ["normal", "Normal"]
  'visual':               ["visual", "Visual"]
  'visual.characterwise': ["visual", "Visual"]
  'visual.linewise':      ["visual", "Visual Line"]
  'visual.blockwise':     ["visual", "Visual Block"]

module.exports =
class StatusBarManager
  constructor: ->
    @element = document.createElement("div")
    @element.id = "status-bar-vim-mode"

    @container = document.createElement("div")
    @container.className = "inline-block"
    @container.appendChild(@element)

  initialize: (@statusBar) ->

  update: (mode, submode) ->
    mode += ".#{submode}" if submode?
    if newContents = ContentsByMode[mode]
      [klass, text] = newContents
      @element.className = "status-bar-vim-mode-#{klass}"
      @element.textContent = text

  # Private
  attach: ->
    @tile = @statusBar.addRightTile(item: @container, priority: 20)

  detach: ->
    @tile.destroy()
