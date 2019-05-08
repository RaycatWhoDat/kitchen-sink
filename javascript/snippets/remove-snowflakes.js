document
    .querySelectorAll('div')
    .forEach(divElement => divElement.style.color === 'rgb(255, 255, 255)' ? divElement.style.color = 'transparent' : null);

document.querySelector('.playstore-button').style.display = 'none';
