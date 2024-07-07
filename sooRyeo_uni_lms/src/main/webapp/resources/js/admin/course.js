/**
 * 
 */
 
let departmentSelect;
let gradeSelect;
let selectedDepartment = "";
let selectedGrade = "";

function fetchData(pageNum) {
    console.log(pageNum);

    const url = '<%=ctxPath%>' + '/admin/curriculumJSON.lms?fk_department_seq=' + selectedDepartment + '&grade=' + selectedGrade + '&currentPage=' + pageNum;

    console.log(url);

    fetch(url)
        .then(response => response.json())
        .then(data => {
            const tableBody = document.querySelector("table tbody");
            tableBody.innerHTML = "";
            console.log(data);

            data.curriculumList.forEach(function(curriculum) {
                const row = document.createElement("tr");
                row.innerHTML = '<td>' + curriculum.name + '</td>' +
                                '<td>' + (curriculum.department_name==''?'교양':curriculum.department_name) + '</td>' +
                                '<td>' + (typeof curriculum.grade == 'undefined' ?'':curriculum.grade) + '</td>' +
                                '<td>' + curriculum.credit + '</td>' +
                                '<td>' + (curriculum.required == 1 ? 'Yes' : 'No') + '</td>';
                row.addEventListener('click', function() {
                    showUpdateModal(curriculum);
                });
                tableBody.appendChild(row);
            });

            const pagination = document.querySelector(".pagination");
            pagination.innerHTML = data.pageBar;
        })
        .catch(error => console.error("Error fetching data:", error));
}

function handleDepartmentChange() {
    const departmentValue = departmentSelect.value;
    if (departmentValue === "") {
        gradeSelect.disabled = true;
    } else {
        gradeSelect.disabled = false;
    }
}

document.addEventListener("DOMContentLoaded", function() {
    departmentSelect = document.getElementById("department");
    gradeSelect = document.getElementById("grade");

    departmentSelect.addEventListener("change", handleDepartmentChange);
    
    console.log(departmentSelect.value);
    console.log(gradeSelect.value);

    const searchButton = document.getElementById("searchButton");
    searchButton.addEventListener('click', function() {
        selectedDepartment = departmentSelect.value;
        selectedGrade = gradeSelect.value;
        fetchData(1);
    });

    // Fetch initial data
    fetchData(1);
    document.getElementById('deleteButton').addEventListener('click', function() {
        const curriculumId = this.getAttribute('data-id');
        if (confirm("삭제 하시겠습니까?")) {
            deleteCurriculum(curriculumId);
        }
    });
    
    
    document.getElementById('updateButton').addEventListener('click', function() {
        const curriculumId = this.getAttribute('data-id');
        if (confirm("수정하시겠습니까?")) {
            updateCurriculum(curriculumId);
        }
    });

    
});

function showUpdateModal(curriculum) {
    document.getElementById('updateName').value = curriculum.name;
    document.getElementById('updateCredit').value = curriculum.credit;
    document.getElementById('updateRequired').checked = curriculum.required == 1;

    // Set the grade select tag
    var gradeSelect = document.getElementById('updateGrade');
    for (var i = 0; i < gradeSelect.options.length; i++) {
        if (gradeSelect.options[i].value == curriculum.grade) {
            gradeSelect.options[i].selected = true;
            break;
        }
    }

    // Set the department select tag
    var departmentSelect = document.getElementById('department_update');
    
    for (var i = 0; i < departmentSelect.options.length; i++) {
    	
    	
        if (departmentSelect.options[i].value == curriculum.fk_department_seq) {
            departmentSelect.options[i].selected = true;
            break;
        }
    }
    
    // Set the delete button data attribute
    const deleteButton = document.getElementById('deleteButton');
    deleteButton.setAttribute('data-id', curriculum.curriculum_seq);
    
    const curriculum_seq = document.getElementById('curriculum_seq');
    curriculum_seq.value=curriculum.curriculum_seq;

    $('#updateModal').modal('show');
}


function deleteCurriculum(id) {
    console.log("deleting : " + id);

    const url = '<%=ctxPath%>' + '/admin/deleteCurriculumREST.lms?curriculum_seq=' + id;
    fetch(url, { method: 'DELETE' })
        .then(response => {
            console.log(response);
            return response.text();  // Extract the response body as text
        })
        .then(body => {
            alert(body);
            $('#updateModal').modal('hide');
            fetchData(1); // Refresh the data
        })
        .catch(error => {
            console.error("삭제 실패: ", error);
            alert("삭제 실패");
        });
}

 function updateCurriculum() {
	    // Get the curriculum_seq from the hidden input field
	    const curriculum_seq = document.getElementById('curriculum_seq').value;

	    // Get the form element
	    const form = document.getElementById('updateForm');

	    // Create a FormData object from the form
	    const formData = new FormData(form);

	    // Convert FormData to a plain object
	    const data = {};
	    formData.forEach((value, key) => {
	        data[key] = value;
	    });

	    // Check the state of the checkbox and set the value
	    const updateRequiredCheckbox = document.getElementById('updateRequired');
	    data.required = updateRequiredCheckbox.checked ? 1 : 0;

	    // Add the curriculum_seq to the data object
	    data.curriculum_seq = curriculum_seq;

	    console.log(data);

	    // Convert the data object to a JSON string
	    const jsonData = JSON.stringify(data);

	    // URL to your update endpoint
	    const url = '<%=ctxPath%>' + '/admin/updateCurriculumREST.lms';

	    // Send the data with fetch
	    fetch(url, {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: jsonData
	    })
	    .then(response => {
	        console.log(response);
	        return response.text();  // Extract the response body as text
	    })
	    .then(body => {
	        alert(body);
	        $('#updateModal').modal('hide');
	        fetchData(1); // Refresh the data
	    })
	    .catch(error => {
	        console.error("업데이트 실패: ", error);
	        alert("업데이트 실패");
	    });
	}

