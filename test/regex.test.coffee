
should = null
respect = require '..'


describe 'Regex comparison', ->

  before ->
    delete Object::should
    chai = require 'chai'
    respect.addToChai chai
    should = chai.should()

  describe 'Regex literal', ->

    it 'should validate matching strings', ->

      { name: 'Sanjuro' }.should.respect { name: /^[TS].*j.r/ }

    itShouldNot 'validate missing non-matching strings', ->
      { name: 'Saburo' }.should.respect { name: /^[TS].*j.r/ }
    , "expected { name: 'Saburo' } to respect { name: /^[TS].*j.r/ } but got { name: 'Saburo' }"

    it 'should validate an equal RegExp', ->
      { pattern: /^[TS].*j.r/ }.should.respect { pattern: /^[TS].*j.r/ }

    itShouldNot 'validate an equal RegExp', ->
      { pattern: /^[TS].*j.r/ }.should.respect { pattern: /^[TS].*j.r/i }
    , 'expected { pattern: /^[TS].*j.r/ } to respect { pattern: /^[TS].*j.r/i } but got { pattern: /^[TS].*j.r/ }'

    itShouldNot 'validate non-strings', ->
      { name: 5 }.should.respect { name: /5/ }
    , 'expected { name: 5 } to respect { name: /5/ } but got { name: 5 }'

    itShouldNot 'not validate null values', ->
      { name: null }.should.respect { name: /null/ }
    , 'expected { name: null } to respect { name: /null/ } but got { name: null }'

    itShouldNot 'validate missing absent values', ->
      { }.should.respect { name: /undefined/ }
    , 'expected {} to respect { name: /undefined/ } but got { name: undefined }'


  describe 'Regex object', ->

    it 'should validate matching strings', ->

      { name: 'Sanjuro' }.should.respect { name: new RegExp('^[TS].*j.r') }

    itShouldNot 'validate missing non-matching strings', ->
      { name: 'Saburo' }.should.respect { name: new RegExp('^[TS].*j.r') }
    , "expected { name: 'Saburo' } to respect { name: /^[TS].*j.r/ } but got { name: 'Saburo' }"