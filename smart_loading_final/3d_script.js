const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.getElementById('3d-container').appendChild(renderer.domElement);

const geometry = new THREE.BoxGeometry(2, 1, 1);
const material = new THREE.MeshBasicMaterial({color: 0x00ff00, wireframe: true});
const container = new THREE.Mesh(geometry, material);
scene.add(container);

camera.position.z = 5;

function animate() {
    requestAnimationFrame(animate);
    container.rotation.y += 0.01;
    renderer.render(scene, camera);
}
animate();