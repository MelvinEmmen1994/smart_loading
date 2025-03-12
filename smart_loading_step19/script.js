document.addEventListener("DOMContentLoaded", function () {
    loadReviews();
});

function loadReviews() {
    let reviews = JSON.parse(localStorage.getItem("reviews") || "[]");
    let reviewDiv = document.getElementById("reviews");
    reviewDiv.innerHTML = "";
    reviews.forEach(review => {
        let div = document.createElement("div");
        div.className = "review";
        div.innerHTML = `<strong>${review.name}</strong> (${review.rating} ★)<br>${review.comment}`;
        reviewDiv.appendChild(div);
    });
}

function addReview() {
    let name = document.getElementById("name").value;
    let rating = document.getElementById("rating").value;
    let comment = document.getElementById("comment").value;

    if (!name || !comment) {
        alert("Vul alle velden in!");
        return;
    }

    let reviews = JSON.parse(localStorage.getItem("reviews") || "[]");
    reviews.push({ name, rating, comment });
    localStorage.setItem("reviews", JSON.stringify(reviews));
    loadReviews();

    document.getElementById("name").value = "";
    document.getElementById("comment").value = "";
}
