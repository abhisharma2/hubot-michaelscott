chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'michaelscott', ->
  beforeEach ->
    @robot =
      hear: sinon.spy()

    require('../src/michaelscott')(@robot)

  it 'registers multiple hear listeners', ->
    # expect(@robot.hear).to.have.been.calledWith(/inspiration/)
    # expect(@robot.hear).to.have.been.calledWith(/huge/)
    # expect(@robot.hear).to.have.been.calledWith(/bankruptcy/)
