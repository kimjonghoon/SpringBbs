window.onload = initPage;

function initPage() {
	var submit = document.getElementById("submit");
	submit.disabled = true;
	var form = document.getElementById("testForm");
	form.onsubmit = check;
	form.agreement.onchange = agree;
}

function agree() {
	var form = document.getElementById("testForm");
	var submit = document.getElementById("submit");
	if (form.agreement.checked == true) {
		submit.disabled = false;	
	} else {
		submit.disabled = true;
	}
}
function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	return true;
}
