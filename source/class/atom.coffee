###
Base class for Atom

@namespace Atoms.Class
@class Atom

@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###
"use strict"

class Atoms.Class.Atom extends Atoms.Core.Module

  @include Atoms.Core.Scaffold
  @include Atoms.Core.Event
  @include Atoms.Core.Output

  @type    = "Atom"
  @default = {}

  ###
  Render element with custom template and bind events (entity or user).
  @method constructor
  @param  attributes  OBJECT
  ###
  constructor: (@attributes) ->
    super
    do @scaffold
    if @entity
      attributes = @entity.parse?() or @entity.attributes()
      @attributes = Atoms.Core.Helper.mix @attributes, attributes

      domain = if Atoms.Entity[@entity.className]? then Atoms.Entity else __.Entity
      entity = @entity.className.toClassObject(domain)
      if entity
        EVENT = Atoms.Core.Constants.ENTITY.EVENT
        entity.bind EVENT.UPDATE, @bindEntityUpdate if @attributes.bind.update
        entity.bind EVENT.DESTROY, @bindEntityDestroy if @attributes.bind.destroy
    do @output
    do @bindEvents

  ###
  Binds to entity update trigger when instance has a entity.
  @method bindEntityUpdate
  @param  instance  ENTITY_INSTANCE
  ###
  bindEntityUpdate: (instance) =>
    if instance.uid is @entity.uid
      @entity[attribute] = value for attribute, value of instance.attributes()
      attributes = @entity.parse?() or @entity.attributes()
      @attributes[attribute] = attributes[attribute] for attribute of attributes
      do @refresh

  ###
  Binds to entity destroy trigger when instance has a entity.
  @method bindEntityDestroy
  @param  instance  ENTITY_INSTANCE
  ###
  bindEntityDestroy: (instance) =>
    do @destroy if instance.uid is @entity.uid

  ###
  Binds to user interface events.
  @method bindEvents
  ###
  bindEvents: ->
    do @handleInputEvent if @attributes.events
