<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath();
%>

<style>

    .container {
        background-color: #d1e0e0;
        padding: 2em;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        max-width: 800px;
        width: 100%;
        text-align: center;
    }

    h1 {
        color: #343a40;
        margin-bottom: 1em;
        font-size: 1.5em;
    }

    input[type="file"] {
        display: none;
    }

    .custom-file-upload {
        border: 1px solid #ccc;
        display: inline-block;
        padding: 0.5em 1em;
        cursor: pointer;
        border-radius: 5px;
        background-color: #738D68;
        color: white;
        font-size: 0.9em;
        margin: 0 0.5em;
        transition: background-color 0.3s ease;
    }

    .custom-file-upload:hover {
        background-color: #0056b3;
    }

    .file-upload-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 1em;
    }

    .file-info {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin: 0 auto;
    }

    .file-name {
        font-size: 0.8em;
        color: #555;
        margin-top: 0.5em;
        word-break: break-all;
        max-width: 150px;
    }

    input[id="titleInput"], input[type="date"], input[type="time"], textarea {
        width: 100%;
        padding: 0.5em;
        margin-bottom: 1em;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 0.9em;
    }

    textarea {
        height: 150px;
        resize: vertical;
    }

    .datetime-inputs {
        display: flex;
        justify-content: space-between;
        margin-bottom: 1em;
    }

    .datetime-inputs > div {
        width: 48%;
    }

    .datetime-group {
        display: flex;
        justify-content: space-between;
    }

    .datetime-group input[type="date"],
    .datetime-group input[type="time"] {
        width: 48%;
    }

    button {
        background-color: #28a745;
        color: white;
        border: none;
        padding: 0.75em 1.5em;
        cursor: pointer;
        border-radius: 5px;
        font-size: 1em;
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #218838;
    }

    .progress-container {
        margin-top: 1em;
        text-align: center;
    }

    progress {
        width: 100%;
        appearance: none;
        height: 20px;
        border-radius: 10px;
        overflow: hidden;
    }

    progress::-webkit-progress-bar {
        background-color: #f3f3f3;
    }

    progress::-webkit-progress-value {
        background-color: #007bff;
    }

    progress::-moz-progress-bar {
        background-color: #007bff;
    }

    #progressText {
        margin-top: 0.5em;
        display: block;
        color: #555;
    }

    #resultMsg {
        margin-top: 1em;
        color: #555;
    }
    .file-list {
        list-style-type: none;
        padding: 0;
        margin: 10px 0;
        max-height: 150px;
        overflow-y: auto;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .file-list li {
        padding: 5px 10px;
        border-bottom: 1px solid #eee;
        font-size: 0.9em;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .file-list li:last-child {
        border-bottom: none;
    }
    .file-list .file-name {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 80%;
    }
    .file-list .file-remove {
        cursor: pointer;
        color: #ff4d4d;
    }

</style>

<div class="container">
    <h1>강의 업로드</h1>
    <form id="uploadForm">
        <input type="hidden" id="course_seq" name="course_seq" value="${requestScope.course_seq}">
        <input type="text" id="titleInput" name="title" placeholder="강의 제목" required>
        <textarea id="contentInput" name="content" placeholder="강의 내용" required></textarea>
        <div class="datetime-inputs">
            <div>
                <label for="startDateInput">시작 날짜 및 시간:</label>
                <div class="datetime-group">
                    <input type="date" id="startDateInput" name="startDate" required>
                    <input type="time" id="startTimeInput" name="startTime" required>
                </div>
            </div>
            <div>
                <label for="endDateInput">종료 날짜 및 시간:</label>
                <div class="datetime-group">
                    <input type="date" id="endDateInput" name="endDate" required>
                    <input type="time" id="endTimeInput" name="endTime" required>
                </div>
            </div>
        </div>
        <div class="file-upload-container">
            <div class="file-info">
                <label for="videoInput" class="custom-file-upload">
                    강의선택
                </label>
                <input type="file" id="videoInput" name="video" accept="video/*" required onchange="updateFileName(this, 'videoFileName')">
                <div id="videoFileName" class="file-name">선택된 파일 없음</div>
            </div>
            <div class="file-info">
                <label for="attachmentInput" class="custom-file-upload">
                    첨부파일
                </label>
                <input type="file" id="attachmentInput" name="attachment" multiple onchange="updateFileNames(this, 'attachmentFileList')">
                <ul id="attachmentFileList" class="file-list">
                    <li>선택된 파일 없음</li>
                </ul>
            </div>
        </div>
        <button type="button" onclick="uploadLecture()">업로드</button>
    </form>
    <div class="progress-container">
        <progress id="progressBar" value="0" max="100"></progress>
        <span id="progressText">0%</span>
    </div>
    <div id="resultMsg"></div>
</div>

<script>
    function updateFileName(input, outputId) {
        const fileName = input.files[0] ? input.files[0].name : "선택된 파일 없음";
        document.getElementById(outputId).textContent = fileName;
    }

    function updateFileNames(input, outputId) {
        const fileList = document.getElementById(outputId);
        fileList.innerHTML = ''; // Clear existing list

        if (input.files.length > 0) {
            Array.from(input.files).forEach((file, index) => {
                const li = document.createElement('li');
                li.innerHTML = `
                <span class="file-name" title="\${file.name}">\${file.name}</span>
                <span class="file-remove" onclick="removeFile(\${index}, '\${input.id}', '\${outputId}')">&times;</span>
            `;
                fileList.appendChild(li);
            });
        } else {
            const li = document.createElement('li');
            li.textContent = "선택된 파일 없음";
            fileList.appendChild(li);
        }
    }

    function removeFile(index, inputId, outputId) {
        const input = document.getElementById(inputId);
        const dt = new DataTransfer();

        Array.from(input.files)
            .filter((_, i) => i !== index)
            .forEach(file => dt.items.add(file));

        input.files = dt.files;
        updateFileNames(input, outputId);
    }

    function uploadLecture() {
        var formData = new FormData();
        var course_seq = document.getElementById('course_seq');
        var titleInput = document.getElementById('titleInput');
        var contentInput = document.getElementById('contentInput');
        var startDateInput = document.getElementById('startDateInput');
        var startTimeInput = document.getElementById('startTimeInput');
        var endDateInput = document.getElementById('endDateInput');
        var endTimeInput = document.getElementById('endTimeInput');
        var videoInput = document.getElementById('videoInput');
        var attachmentInput = document.getElementById('attachmentInput');

        formData.append('course_seq', course_seq.value);
        formData.append('title', titleInput.value);
        formData.append('content', contentInput.value);
        formData.append('startDateTime', startDateInput.value + 'T' + startTimeInput.value);
        formData.append('endDateTime', endDateInput.value + 'T' + endTimeInput.value);

        if (!videoInput.files[0]) {
            alert("강의를 선택하시오");
            return;
        }

        formData.append('video', videoInput.files[0]);



        // Append multiple attachment files
        for (let i = 0; i < attachmentInput.files.length; i++) {
            formData.append('attachment', attachmentInput.files[i]);
        }

        var xhr = new XMLHttpRequest();
        xhr.open('POST', '<%=ctxPath%>/professor/courseUploadREST.lms', true);

        xhr.upload.onprogress = function(event) {
            if (event.lengthComputable) {
                var percentComplete = (event.loaded / event.total) * 100;
                document.getElementById('progressBar').value = percentComplete;
                document.getElementById('progressText').innerText = Math.round(percentComplete) + '%';
            }
        };

        xhr.onload = function() {
            if (xhr.status === 200) {
                document.getElementById('resultMsg').innerText = '강의가 성공적으로 업로드되었습니다';
                alert("강의가 업로드 되었습니다.")
                location.href="<%=ctxPath%>/professor/courseDetail.lms?course_seq="+${requestScope.course_seq}
            } else {
                document.getElementById('resultMsg').innerText = '강의 업로드에 실패했습니다';
            }
            document.getElementById('progressBar').value = 0;  // Reset progress bar
            document.getElementById('progressText').innerText = '0%';
        };

        xhr.onerror = function() {
            document.getElementById('resultMsg').innerText = '강의 업로드에 실패했습니다';
            document.getElementById('progressBar').value = 0;  // Reset progress bar
            document.getElementById('progressText').innerText = '0%';
        };

        xhr.send(formData);
    }
</script>