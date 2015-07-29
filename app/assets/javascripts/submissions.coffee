# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@SubmissionPoller =
  pendingSubmissionIds: []
  start: (pendingSubmissionIds) ->
    SubmissionPoller.pendingSubmissionIds = pendingSubmissionIds
    setInterval(SubmissionPoller.poll, 5000)
  poll: ->
    if SubmissionPoller.pendingSubmissionIds.length > 0
      console.log "Polled #{SubmissionPoller.pendingSubmissionIds} on #{new Date()}"
    else
      console.log "Nothing to poll for"
  addSubmissionToPoll: (submissionId) ->
    index = SubmissionPoller.pendingSubmissionIds.indexOf(submissionId)
    if (index == -1)
      SubmissionPoller.pendingSubmissionIds.push(submissionId)
  removeSubmissionFromPoll: (submissionId) ->
    index = SubmissionPoller.pendingSubmissionIds.indexOf(submissionId)
    if (index > -1)
      SubmissionPoller.pendingSubmissionIds.splice(index, 1)
