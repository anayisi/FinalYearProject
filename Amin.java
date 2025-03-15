 document.addEventListener('DOMContentLoaded', function() {
            fetch('Admin.php')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('user-type').textContent = 'Administrator';
                    document.getElementById('user-name').textContent = data.administrator.name;
                    document.getElementById('user-email').textContent = data.administrator.email;
                    document.getElementById('user-dob').textContent = data.administrator.dob;
                    
                    // Populate all students' results
                    const allResultsTableBody = document.getElementById('all-results-table-body');
                    data.all_results.forEach(result => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${result.name}</td>
                            <td>${result.email}</td>
                            <td>${result.exam_id}</td>
                            <td>${result.score}</td>
                        `;
                        allResultsTableBody.appendChild(row);
                    });
                } else {
                        alert('Failed to load user details.');}
            })
            .catch(error => console.error('Error:', error));
        });
        // Function to fetch questions
        function fetchQuestions() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "fetch_questions.php", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById("questionTable").innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }

        // Call fetchQuestions on page load
        window.onload = fetchQuestions;

        function removeQuestion(button) {
            var row = button.parentElement.parentElement;
            var questionId = row.cells[0].innerHTML;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "delete_question.php", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    fetchQuestions();
                }
            };
            xhr.send("id=" + questionId);
        } let currentUser = null;

        function loadUsers() {
            $.ajax({
                url: 'fetch_users.php',
                method: 'POST',
                success: function(response) {
                    $('#user_list').html(response);
                }
            });
        }

        function loadMessages() {
            if (currentUser) {
                $.ajax({
                    url: 'fetch_messages.php',
                    method: 'POST',
                    data: { id: currentUser },
                    success: function(response) {
                        $('#message_area').html(response);
                    }
                });
            }
        }

        $(document).ready(function() {
            loadUsers();

            $('#user_list').on('click', '.user-item', function() {
                currentUser = $(this).data('id');
                loadMessages();
            });

            $('#feedback_form').submit(function(e) {
                e.preventDefault();
                const message = $('#message_input').val();
                if (message && currentUser) {
                    $.ajax({
                        url: 'send_message.php',
                        method: 'POST',
                        data: { message: message, receiver_id: currentUser },
                        success: function(response) {
                            $('#message_input').val('');
                            loadMessages();
                        }
                    });
                }
            });

            $('#back_button').click(function() {
                $('#message_area').html('');
                currentUser = null;
            });
        });
    </script>
    <script>
        function showSection(sectionId) {
            var sections = document.getElementsByClassName('content-section');
            for (var i = 0; i < sections.length; i++) {
                sections[i].classList.remove('active');
            }
            document.getElementById(sectionId).classList.add('active');
        }

        function editDetails() {
            document.getElementById('details-view').style.display = 'none';
            document.getElementById('details-edit').style.display = 'block';

            document.getElementById('editAdminName').value = document.getElementById('user-name').innerText;
            document.getElementById('editAdminEmail').value = document.getElementById('user-email').innerText;
            document.getElementById('editAdminDob').value = document.getElementById('user-dob').innerText;
        }

        function saveDetails() {
            var name = document.getElementById('editAdminName').value;
            var email = document.getElementById('editAdminEmail').value;
            var dob = document.getElementById('editAdminDob').value;
        
            // AJAX request to update details in the database
            fetch('updateAdmindetails.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    name: name,
                    email: email,
                    dob: dob
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Update the UI with the new details
                    document.getElementById('user-name').innerText = name;
                    document.getElementById('user-email').innerText = email;
                    document.getElementById('user-dob').innerText = dob;
                    cancelEdit();
                    alert('Details updated successfully');
                } else {
                    alert('Failed to update details');
                }
            })
            .catch(error => console.error('Error:', error));
        }

        function cancelEdit() {
            document.getElementById('details-view').style.display = 'block';
            document.getElementById('details-edit').style.display = 'none';
        }

        function fetchResults() {
            const exam_id = document.getElementById('exam_idd').value;
            
            if (exam_id) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'fetch_results_admin.php', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        document.getElementById('resultContainer').innerHTML = xhr.responseText;
                    }
                };
                
                xhr.send('exam_id=' + exam_id);
            } else {
                alert('Please enter an Exam ID.');
            }
        }
            // Function to fetch student details from the PHP script
    function fetchStudents() {
        fetch('fetch_students.php')
            .then(response => response.json())
            .then(data => {
                let tableBody = document.getElementById('studentApprovalTable');
                tableBody.innerHTML = ""; // Clear any existing rows

                data.forEach(student => {
                    let row = `<tr>
                                    <td>${student.name}</td>
                                    <td>${student.dob}</td>
                                    <td>${student.school}</td>
                                    <td>${student.student_id}</td>
                                    <td>
                                        <button class="btn btn-danger" onclick="rejectUser(${student.student_id}, 'student')">Reject</button>
                                    </td>
                                </tr>`;
                    tableBody.insertAdjacentHTML('beforeend', row);
                });
            })
            .catch(error => {
                console.error('Error fetching students:', error);
            });
    }

    // Function to fetch lecturer details from the PHP script
    function fetchLecturers() {
        fetch('fetch_lecturers.php')
            .then(response => response.json())
            .then(data => {
                let tableBody = document.getElementById('lecturerApprovalTable');
                tableBody.innerHTML = ""; // Clear any existing rows

                data.forEach(lecturer => {
                    let row = `<tr>
                                    <td>${lecturer.name}</td>
                                    <td>${lecturer.dob}</td>
                                    <td>${lecturer.school}</td>
                                    <td>${lecturer.lecturer_id}</td>
                                    <td>
                                        <button class="btn btn-danger" onclick="rejectUser(${lecturer.lecturer_id}, 'lecturer')">Reject</button>
                                    </td>
                                </tr>`;
                    tableBody.insertAdjacentHTML('beforeend', row);
                });
            })
            .catch(error => {
                console.error('Error fetching lecturers:', error);
            });
    }

    // JavaScript function to reject a user (either student or lecturer)
    function rejectUser(userId, userType) {
    let url;

    // Determine the appropriate URL based on user type (student or lecturer)
    if (userType === 'student') {
        url = `reject_student.php?student_id=${userId}`;
    } else if (userType === 'lecturer') {
        url = `reject_lecturer.php?lecturer_id=${userId}`;
    }

    if (confirm('Are you sure you want to reject this user?')) {
        fetch(url)
            .then(response => response.text())
            .then(data => {
                alert(data); // Show the response message
                if (userType === 'student') {
                    fetchStudents(); // Refresh the student list
                } else {
                    fetchLecturers(); // Refresh the lecturer list
                }
            })
            .catch(error => {
                console.error('Error rejecting user:', error);
            });
    }
}

    // Fetch both students and lecturers when the page loads
    window.onload = function() {
        fetchStudents(); // Fetch student data
        fetchLecturers(); // Fetch lecturer data
    };        