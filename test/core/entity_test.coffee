require_src 'core/entity'

describe 'tome.Entity', ->

  it 'is a function', ->
    expect(tome.Entity).to.be.a 'function'

  describe 'constructor( components )', ->
    it 'adds passed components to new entity', ->
      components = [name: 'comp', value: 'onent']
      e = new tome.Entity components
      expect(e.components.comp).to.eql components[0]

  describe '.id()', ->
    it "returns the entity's id", ->
      e = new tome.Entity
      expect(e.id()).not.eql null

    it "returns the same entity id each time it's called", ->
      e = new tome.Entity
      id = e.id()
      expect(e.id()).to.eql id
