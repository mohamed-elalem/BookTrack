App.suggestion = App.cable.subscriptions.create "SuggestionChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'Successfully connected to websocket'

  disconnected: ->
    # Called when the subscription has been terminated by the server
