App.main = App.cable.subscriptions.create "MainChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    appendImage(data.image_data) if data.image_data

  sendImage: (element) ->
    file = getFileFrom element
    readFile file, (content) ->
      App.main.perform('send_image', {content})

getFileFrom = (element) ->
  element.prop('files')[0]

readFile = (file, callback) ->
  reader = new FileReader()
  reader.readAsDataURL(file)
  reader.onload = ->
    callback(reader.result)
  reader.onerror = (error) ->
    console.log('Error: ', error)

appendImage = (content) ->
  node = $("<img style='height: 10em; margin: 1em' src=" + content + " />")
  $("#images").prepend(node)

