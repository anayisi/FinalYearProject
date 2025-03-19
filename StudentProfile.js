document.addEventListener('DOMContentLoaded', function() {
    fetch('Student.php')
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            document.getElementById('user-type').textContent = 'Student';
            document.getElementById('user-name').textContent = data.student.name;
            document.getElementById('user-email').textContent = data.student.email;
            document.getElementById('user-dob').textContent = data.student.dob;
            /*
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
            */
        } else {
                alert('Failed to load user details.');}
    })
    .catch(error => console.error('Error:', error));
});