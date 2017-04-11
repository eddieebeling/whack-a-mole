angular.module('app', []).controller 'MainCtrl', ($scope, $timeout,$interval) ->
  
  $ctrl = @
  $scope.$ctrl = @

  @data =
    title: 'Whack-a-mole'
    username: 'eddieebeling'
    score: 0
    showNewGameLink: false
    holes:[
      {"id": "1","active":false},
      {"id": "2","active":false},
      {"id": "3","active":false},
      {"id": "4","active":false},
      {"id": "5","active":false},
      {"id": "6","active":false},
      {"id": "7","active":false},
      {"id": "8","active":false},
      {"id": "9","active":false}]

  @hideMole = ->
    angular.forEach $ctrl.data.holes, (item, key) ->
      if item.active is true
        item.active = false
      return
    return
  
  @showMole = ->
    $ctrl.hideMole()
    $timeout ->
      holes = $ctrl.data.holes
      holes[Math.floor(holes.length * Math.random())].active = true
    , 100
    return
  
  @whackMole = (item) ->
    isActive = item.active is true
    if isActive
      console.log('Mole number ' + item.id + ' hit!')
      $ctrl.data.score++
      $ctrl.showMole()
    else 
      $ctrl.showMole()
    return
  
  $scope.$watch ->
    return $ctrl.data.score
  , (newValue, oldValue) ->
    if newValue > 9
      alert('Congratulations, you won!')
      $ctrl.endGame()
    else
    return
  
  @startGame = ->
    $ctrl.data.score = 0
    $ctrl.data.showNewGameLink = false
    $ctrl.interval = $interval ->
      $ctrl.showMole()
    , 4000
    return
  
  @endGame = ->
    $interval.cancel($ctrl.interval)
    $timeout ->
      $ctrl.hideMole()
      $ctrl.data.showNewGameLink = true
    , 120
    return
  
  @init = ->
    $ctrl.startGame()
    return
        
  $ctrl.init()
  
  return