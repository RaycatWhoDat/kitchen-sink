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

  auto window = SDL_CreateWindow(
      toStringz("This is a test."),
      SDL_WINDOWPOS_UNDEFINED,
      SDL_WINDOWPOS_UNDEFINED,
      500,
      500,
      SDL_WINDOW_OPENGL);

  if (window == null) {
    writeln("No window found.");
    return;
  }

  auto renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
  auto cover = SDL_CreateTextureFromSurface(renderer, SDL_LoadBMP("./image.bmp"));

  SDL_RenderClear(renderer);
  SDL_RenderCopy(renderer, cover, null, null);
  SDL_RenderPresent(renderer);
    
  SDL_Delay(2000);
  SDL_DestroyWindow(window);
  SDL_Quit();
}

void main() {
  init();
}
