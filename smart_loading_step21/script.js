function calculateContainer() {
    let width = parseInt(document.getElementById("palletWidth").value);
    let length = parseInt(document.getElementById("palletLength").value);
    let count = parseInt(document.getElementById("palletCount").value);

    let containerSize = ["20ft", "40ft", "40ft High Cube"];
    let chosenContainer = "Te klein";

    if (count * (width * length) <= 300000) {
        chosenContainer = containerSize[0];
    } else if (count * (width * length) <= 600000) {
        chosenContainer = containerSize[1];
    } else if (count * (width * length) <= 700000) {
        chosenContainer = containerSize[2];
    }

    document.getElementById("result").innerText = "Aanbevolen container: " + chosenContainer;

    drawVisualization(count);
}

function drawVisualization(count) {
    let canvas = document.getElementById("visualization");
    let ctx = canvas.getContext("2d");
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    let cols = 5;
    let rows = Math.ceil(count / cols);
    let size = 40;

    for (let i = 0; i < count; i++) {
        let x = (i % cols) * size + 10;
        let y = Math.floor(i / cols) * size + 10;
        ctx.fillStyle = "blue";
        ctx.fillRect(x, y, size - 5, size - 5);
        ctx.strokeRect(x, y, size - 5, size - 5);
    }
}
