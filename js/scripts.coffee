keyframesOl = document.querySelector('.keyframes')
outputWrap = document.querySelector('.output')

keyframeTemplate = "<li class='keyframe'>
  <input type='number' placeholder='Time in seconds' />
  <span class='remove-keyframe'>&times;</span>
</li>"


addKeyframe = ->
  $(keyframesOl).append($(keyframeTemplate))


removeKeyframe = (li) ->
  keyframesOl.removeChild(li)
  createOutput()


createOutput = ->
  keyframeFields = document.querySelectorAll('.keyframe input')
  output = "@keyframes animationName { \n"
  totalDur = null
  i = keyframeFields.length - 1
  pre = document.createElement('pre')
  pre.classList.add('output')
  pre.setAttribute('data-language', 'css')

  # Calculate total length of animation
  while i >= 0 && !totalDur
    if keyframeFields[i].value.trim != ""
      totalDur = keyframeFields[i].value
    i--

  # Calculate percentage of each keyframe
  for frame, n in keyframeFields
    return if !frame.value
    perc = (frame.value / totalDur) * 100
    output += "  /* Frame #{n + 1}: Starts at #{frame.value}s */ \n"
    output += "  #{+perc.toFixed(2)}% {} \n"

  output += "}"
  output = "animation: animationName #{totalDur}s;\n\n#{output}"

  pre.innerHTML = output
  outputWrap.innerHTML = ''
  outputWrap.appendChild(pre)

  Rainbow.color()


$ ->
  $('.js-add-keyframe').on 'click', ->
    addKeyframe()

  $(document).on 'click', '.remove-keyframe', ->
    removeKeyframe(this.parentNode)

  $(document).on 'keyup', '.keyframe input', ->
    createOutput()