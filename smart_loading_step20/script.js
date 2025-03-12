document.addEventListener("DOMContentLoaded", function () {
    addBotMessage("Welkom! Hoe kan ik u helpen?");
});

function sendMessage() {
    let userInput = document.getElementById("userInput").value;
    if (!userInput) return;
    
    addUserMessage(userInput);
    document.getElementById("userInput").value = "";

    setTimeout(() => {
        let response = getBotResponse(userInput);
        addBotMessage(response);
    }, 1000);
}

function addUserMessage(message) {
    let chatlogs = document.getElementById("chatlogs");
    let div = document.createElement("div");
    div.className = "user-message";
    div.innerText = "U: " + message;
    chatlogs.appendChild(div);
}

function addBotMessage(message) {
    let chatlogs = document.getElementById("chatlogs");
    let div = document.createElement("div");
    div.className = "bot-message";
    div.innerText = "Bot: " + message;
    chatlogs.appendChild(div);
}

function getBotResponse(input) {
    let responses = {
        "hallo": "Hallo! Hoe kan ik u helpen?",
        "help": "Ik kan u helpen met veelgestelde vragen. Waar zoekt u hulp bij?",
        "prijs": "De prijsinformatie vindt u op onze website onder 'Tarieven'.",
        "contact": "U kunt ons bereiken via het contactformulier of telefonisch.",
        "bedankt": "Graag gedaan!"
    };

    let lowerInput = input.toLowerCase();
    return responses[lowerInput] || "Ik begrijp het niet helemaal. Kunt u het anders formuleren?";
}
