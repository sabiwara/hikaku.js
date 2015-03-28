
Comparator = require './comparator'


class RespectPlugin extends Comparator

  KEYWORD: 'respect'

  chaiAssert: (ctx) ->
    keyword = @KEYWORD
    ctx.assert(
      @conform,
      "expected #{'#{this}'} to #{keyword} #{'#{exp}'}",
      "expected #{'#{this}'} not to #{keyword} #{'#{exp}'} (false negative fail)",
      @expected,
      @displayActual
    )

  shouldAssert: (ctx) ->
    ctx.params =
      operator: "to #{ @KEYWORD }"
      expected: @expected
    if !@conform
      ctx.fail()

  ###
  STATICS
  ###

  @spawnSubClass: (alias) ->
    class ComparatorClass extends @
    ComparatorClass::KEYWORD = alias if alias
    return ComparatorClass

  @chaiPlugin: (alias) ->
    (chai, utils) =>
      ComparatorClass = @spawnSubClass alias
      utils.addMethod chai.Assertion.prototype, ComparatorClass::KEYWORD, (expected, options) ->
        comparator = new ComparatorClass(expected, this._obj, options)
        comparator.chaiAssert(this)

  @shouldPlugin: (alias) ->
    (should, Assertion) =>
      ComparatorClass = @spawnSubClass alias
      Assertion.add ComparatorClass::KEYWORD, (expected, options) ->
        comparator = new ComparatorClass(expected, this.obj, options)
        comparator.shouldAssert(this)


module.exports = RespectPlugin