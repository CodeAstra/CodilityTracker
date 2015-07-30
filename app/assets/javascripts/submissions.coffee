# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@SubmissionPoller =
  pendingSubmissionIds: []
  init: (pendingSubmissionIds) ->
    SubmissionPoller.pendingSubmissionIds = pendingSubmissionIds
    if SubmissionPoller.pendingSubmissionIds.length > 0
      SubmissionPoller.start()
  start: ->
    SubmissionPoller.pollLooper = setInterval(SubmissionPoller.poll, 5000)
  stop: ->
    clearInterval SubmissionPoller.pollLooper
  poll: ->
    console.log "Polled #{SubmissionPoller.pendingSubmissionIds} on #{new Date()}"
  addSubmissionToPoll: (submissionId) ->
    index = SubmissionPoller.pendingSubmissionIds.indexOf(submissionId)
    if (index == -1)
      SubmissionPoller.pendingSubmissionIds.push(submissionId)
    if SubmissionPoller.pendingSubmissionIds.length == 1
      SubmissionPoller.start()
  removeSubmissionFromPoll: (submissionId) ->
    index = SubmissionPoller.pendingSubmissionIds.indexOf(submissionId)
    if (index > -1)
      SubmissionPoller.pendingSubmissionIds.splice(index, 1)
    if SubmissionPoller.pendingSubmissionIds.length == 0
      SubmissionPoller.stop()
