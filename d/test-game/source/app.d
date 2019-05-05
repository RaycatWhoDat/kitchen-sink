import std.stdio;
import std.string;

import bindbc.sdl;

import bindbc.sdl.image;
import bindbc.sdl.mixer;
import bindbc.sdl.ttf;

void init() {
  loadSDL();
  
  loadSDLImage();
  loadSDLMixer();
  loadSDLTTF();

  auto window = SDL_CreateWindow(toStringz("This is a test."),SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 500, 500, SDL_WINDOW_SHOWN);

  if (window == null) {
    writeln("No window found.");
    return;
  }

  auto screenSurface = SDL_GetWindowSurface(window);
  // auto cover = IMG_Load("image.jpg");

  // if (cover == null) {
  //   writeln("No image.");
  //   return;
  // }
  
  SDL_UpdateWindowSurface(window);
  SDL_Delay(2000);
  SDL_DestroyWindow(window);
  SDL_Quit();
}

void main() {
  init();
}
