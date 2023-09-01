function renderButtons(radarFooter) {
  const buttonsRow = radarFooter.append('div').classed('buttons', true)

  buttonsRow
    .append('button')
    .classed('buttons__wave-btn', true)
    .text('Skriv ut radaren')
    .on('click', window.print.bind(window))
}

module.exports = {
  renderButtons,
}
