import * as PIXI from 'pixi.js';
import { Geometry, Mesh, Shader, Texture } from 'pixi.js';
import { assets, fragment, mesh, vertex } from './constants';

/* eslint-disable */
window.addEventListener('load', () => {
    console.warn('shader_01');
});

const app = new PIXI.Application({
    resizeTo: document.body,
    width: document.documentElement.clientWidth,
    height: window.innerHeight,
});

app.view.width = window.innerWidth;
app.view.height = window.innerHeight;
document.body.appendChild(app.view);

const geometry = new Geometry();
geometry
    //
    .addAttribute('aVertexPosition', mesh.vertices, 2);

geometry
    //
    .addAttribute('aUvs', mesh.uvs, 2)
    .addIndex(mesh.indices);

const uniforms = {
    uTime: 0,
    uSampler: Texture.from(assets.texture),
    uBounds: [window.innerWidth, window.innerHeight],
};

const shader = Shader.from(vertex, fragment, uniforms);
const quad = new Mesh(geometry, shader);

quad.scale.set(0.5);
quad.position.set(document.documentElement.clientWidth / 2 - 200, window.innerHeight / 2 + 150);

app.stage.addChild(quad);

app.ticker.add((delta) => {
    quad.shader.uniforms.uTime += 0.02;
});
