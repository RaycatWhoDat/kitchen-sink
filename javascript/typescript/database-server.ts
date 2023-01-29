// http://localhost:4000/set?somekey=somevalue
// http://localhost:4000/get?key=somekey

import { Server, Request, ConnInfo } from 'https://deno.land/std@0.174.0/http/server.ts';
import { ensureFileSync } from "https://deno.land/std@0.174.0/fs/mod.ts";

const PORT = 4000;
let __state: Record<string, string> = {};
const stateFilePath = "./state.json";

const notFoundRoute = (): Response => {
  return new Response("Not Found", { status: 404 });
}

const getRoute = (request: Request, connInfo: ConnInfo, { params }: Record<string, any>): Response => {
  const { key } = params ?? {};

  ensureFileSync(stateFilePath);

  try {
    __state = JSON.parse(Deno.readTextFileSync(stateFilePath));
  } catch {
    __state = {};
  }

  const body = __state[key] ? `Value: ${__state[key]}` : 'Key not found.';
  const status = __state[key] ? 200 : 404

  return new Response(body, { status });
}

const setRoute = (request: Request, connInfo: ConnInfo, { params }: Record<string, any>): Response => {
  const setKeys = [];
  for (let [key, value] of Object.entries(params)) {
    __state[key] = value;
    setKeys.push(key);
  }

  Deno.writeTextFileSync(stateFilePath, JSON.stringify(__state));

  return new Response(`Successfully set keys: ${setKeys.join(', ')}.`, { status: 200 });
};

const routes: Record<string, (request: Request, connInfo: ConnInfo, payload: Record<string, any>) => Response> = {
  '/get': getRoute,
  '/set': setRoute
};

const rootHandler = (request: Request, connInfo: ConnInfo): Response => {
  const { url } = request ?? {};
  const [path, ...rawParams] = url
    .replace(new RegExp(`http://(?:localhost|127\.0\.0\.1):${PORT}`), '')
    .split(/\?|&/g);

  const params: Record<string, string> = {};

  for (const param of rawParams) {
    const [key, value] = param.split('=') ?? [];
    params[key] = value;
  }

  const payload = { params };

  return routes[path] ? routes[path](request, connInfo, payload) : notFoundRoute();
};

const server = new Server({ port: PORT, handler: rootHandler });

console.log(`Now listening on port ${PORT}.`);
await server.listenAndServe();
