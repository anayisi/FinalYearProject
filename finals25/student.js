const admins = [
    { id: "ADM001", name: "Aadil (Developer)" },
    { id: "ADM002", name: "Hajara (Developer)" },
    { id: "ADM003", name: "Muhammadu (Developer)" }
];

const chatHistory = {
    "ADM001": [
        { sender: "ADM001", message: "Hello Aadil, how can I help you today?", time: "2023-06-10 10:30" },
        { sender: "STD2023001", message: "Hi Hajara, I have a question about my course selection.", time: "2023-06-10 10:32" }
    ],
    "ADM002": [
        { sender: "ADM002", message: "Your exam schedule has been updated.", time: "2023-06-05 14:15" }
    ]
};

// Edit Details Modal functionality
const editModal = document.getElementById('editModal');
const editDetailsBtn = document.getElementById('editDetailsBtn');
const closeModal = document.getElementById('closeModal');
const cancelEdit = document.getElementById('cancelEdit');

editDetailsBtn.addEventListener('click', () => {
    editModal.style.display = 'block';
    // Populate current details in the modal fields
    document.getElementById('editName').value = document.getElementById('userName').innerText;
    document.getElementById('editEmail').value = document.getElementById('userEmail').innerText;
    document.getElementById('editDob').value = document.getElementById('userDob').innerText;
});

closeModal.addEventListener('click', () => {
    editModal.style.display = 'none';
});

cancelEdit.addEventListener('click', () => {
    editModal.style.display = 'none';
});

window.addEventListener('click', function(event) {
    if (event.target === editModal) {
        editModal.style.display = 'none';
    }
});

// Form submission
document.getElementById('editForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Get form values
    const name = document.getElementById('editName').value;
    const email = document.getElementById('editEmail').value;
    const dob = document.getElementById('editDob').value;
    
    // Update displayed values
    document.getElementById('userName').textContent = name;
    document.getElementById('userEmail').textContent = email;
    document.getElementById('userDob').textContent = dob;
    
    //update the database with new values
    fetch('UpdateStudentDetails.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            name: name,
            email: email,
            dob: dob
        })
    })
    
    // Show success message
    alert('Details updated successfully!');

    // Close modal
    editModal.style.display = 'none';
});

// DOM Elements
const tabButtons = document.querySelectorAll('.tab-btn');
const tabContents = document.querySelectorAll('.tab-content');
const startExamBtn = document.getElementById('startExamBtn');
const examIdInput = document.getElementById('examIdInput');
const examContent = document.getElementById('examContent');
const questionsContainer = document.getElementById('questionsContainer');
const examForm = document.getElementById('examForm');
const submitExamBtn = document.getElementById('submitExamBtn');
const instructionsModal = document.getElementById('instructionsModal');
const beginExamBtn = document.getElementById('beginExamBtn');
const examTimer = document.getElementById('examTimer');
const totalTimeDisplay = document.getElementById('totalTimeDisplay');
const resultModal = document.getElementById('resultModal');
const resultScore = document.getElementById('resultScore');
const closeResultModalBtn = document.getElementById('closeResultModalBtn');
const viewResultsBtn = document.getElementById('viewResultsBtn');
const resultExamId = document.getElementById('resultExamId');
const resultsTableContainer = document.getElementById('resultsTableContainer');
const resultsTableBody = document.getElementById('resultsTableBody');
const adminList = document.getElementById('adminList');
const conversationArea = document.getElementById('conversationArea');
const messageInput = document.getElementById('messageInput');
const sendMessageBtn = document.getElementById('sendMessageBtn');

// Current state
let examQuestions = {};
let currentExamId = null;
let currentExamTimer = null;
let examTimeLeft = 0;
let currentAdminId = null;
let examStarted = false;

function startExam() {
    // Check if window is maximized
    const isMaximized = window.innerWidth >= screen.availWidth && window.innerHeight >= screen.availHeight;

    if (!isMaximized) {
        alert('Please maximize your browser window before starting the exam.');
        return;
    }

    instructionsModal.style.display = 'none';
    examStarted = true;
    startExamBtn.disabled = true;

    // Clone and shuffle questions array
    const questions = [...examQuestions[currentExamId]];
    
    for (let i = questions.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [questions[i], questions[j]] = [questions[j], questions[i]];
    }

    questionsContainer.innerHTML = '';

    questions.forEach((question, index) => {
        // Map correct_answer (A/B/C/D) to the actual text
        const optionsMap = {
            A: question.options[0],
            B: question.options[1],
            C: question.options[2],
            D: question.options[3]
        };

        const correctOptionText = optionsMap[question.correct_answer];

        // Build array of option objects with correctness flag
        const optionObjects = question.options.map(opt => ({
            text: opt,
            isCorrect: opt === correctOptionText
        }));

        // Shuffle options
        for (let i = optionObjects.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [optionObjects[i], optionObjects[j]] = [optionObjects[j], optionObjects[i]];
        }

        // Store correct answer text after shuffling
        question.shuffledCorrectAnswer = optionObjects.find(opt => opt.isCorrect).text;

        // Render question
        const questionDiv = document.createElement('div');
        questionDiv.className = 'question-container';
        questionDiv.innerHTML = `
            <h4 class="font-semibold mb-2">Question ${index + 1}: ${question.text}</h4>
            <div class="space-y-2 ml-4">
                ${optionObjects.map((option, i) => `
                    <label class="flex items-center">
                        <input type="radio" name="q${question.id}" value="${option.text}" class="mr-2">
                        ${String.fromCharCode(65 + i)}. ${option.text}
                    </label>
                `).join('')}
            </div>
        `;

        // Store correct answer and question ID for later grading
        questionDiv.dataset.questionId = question.id;
        questionDiv.dataset.correctAnswer = question.shuffledCorrectAnswer;

        questionsContainer.appendChild(questionDiv);
    });

    // Save the updated questions with tracked answers
    examQuestions[currentExamId] = questions;

    // Start timer
    examContent.classList.remove('hidden');
    updateTimerDisplay();
    currentExamTimer = setInterval(updateTimer, 1000);
}

function updateTimer() {
    examTimeLeft--;
    updateTimerDisplay();
    
    if (examTimeLeft <= 0) {
        submitExam();
    }
}

function updateTimerDisplay() {
    const minutes = Math.floor(examTimeLeft / 60);
    const seconds = examTimeLeft % 60;
    examTimer.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    
    // Change color when time is running low
    if (examTimeLeft <= 10) {
        examTimer.classList.add('animate-pulse');
    } else {
        examTimer.classList.remove('animate-pulse');
    }
}

function submitExam() {
    if (!examStarted) return;

    examStarted = false;
    clearInterval(currentExamTimer);
    
    const questions = examQuestions[currentExamId];
    let correctAnswers = 0;

    questions.forEach((question) => {
        const selectedOption = document.querySelector(`input[name="q${question.id}"]:checked`);
        if (selectedOption && selectedOption.value === question.shuffledCorrectAnswer) {
            correctAnswers++;
        }
    });

    const score = `${correctAnswers}/${questions.length}`;

    // Send results to backend
    fetch('submit_results.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            exam_id: currentExamId,
            score: score
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert('Exam submitted successfully!');
            resetExamState();
        } else {
            alert('Error submitting exam: ' + data.message);
        }
    })
    .catch(err => {
        console.error('Error Sending Scores: ', err);
    });

    // Show result
    resultScore.textContent = score;
    resultModal.style.display = 'block';
    
    // Reset exam UI
    examContent.classList.add('hidden');
    examIdInput.value = '';
    startExamBtn.disabled = false; //Re-enable start button
}

function showExamInstructions(examId) {
    const questions = examQuestions[examId];
    const totalTime = questions.length * 30; // 30 seconds per question
    examTimeLeft = totalTime;
    
    // Display total time in minutes and seconds
    const minutes = Math.floor(totalTime / 60);
    const seconds = totalTime % 60;
    totalTimeDisplay.textContent = `${minutes > 0 ? minutes + ' minute' + (minutes > 1 ? 's' : '') + ' and ' : ''}${seconds} seconds`;
    
    instructionsModal.style.display = 'block';
}

function showResults(examId) {
    fetch('get_resultsForStudents.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ exam_id: examId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success && data.results.length > 0) {
            resultsTableBody.innerHTML = '';

            data.results.forEach(result => {
                const row = document.createElement('tr');
                row.className = 'hover:bg-gray-50';
                row.innerHTML = `
                    <td class="py-3 px-4">${result.student_name}</td>
                    <td class="py-3 px-4">${result.student_idNum}</td>
                    <td class="py-3 px-4">${result.exam_id}</td>
                    <td class="py-3 px-4">${result.result_id}</td>
                    <td class="py-3 px-4">${result.score}</td>
                `;
                resultsTableBody.appendChild(row);
            });

            resultsTableContainer.classList.remove('hidden');
        } else {
            alert('No results found for this exam ID');
        }
    })
    .catch(error => {
        console.error('Error fetching results:', error);
        alert('An error occurred while fetching results.');
    });
}

startExamBtn.addEventListener('click', function () {
    if (examStarted) return;
    
    const examId = examIdInput.value.trim();

    if (!examId) {
        alert('Please enter an Exam ID.');
        return;
    }

    // Check if window is maximized
    const isMaximized = window.innerWidth >= screen.availWidth && window.innerHeight >= screen.availHeight;

    if (!isMaximized) {
        alert('Please maximize your browser window before starting the exam.');
        return;
    }

    fetch(`getExamQuestions.php?exam_id=${encodeURIComponent(examId)}`)
        .then(response => response.json())
        .then(data => {
            if (data.success && data.questions.length > 0) {
                examQuestions[examId] = data.questions;
                currentExamId = examId;
                showExamInstructions(examId);
            } else {
                alert('Invalid Exam ID or no questions available for this exam.');
            }
        })
        .catch(error => {
            console.error('Error fetching questions:', error);
            alert('An error occurred while loading the exam.');
        });
    
});

// Begin exam after instructions
beginExamBtn.addEventListener('click', startExam);

// Submit exam
examForm.addEventListener('submit', function(e) {
    e.preventDefault();
    submitExam();
});

function tryAutoSubmitExam(reason) {
    if (typeof examStarted !== 'undefined' && examStarted === true && typeof submitExam === 'function') {
        console.log(reason + " - submitting exam automatically.");
        submitExam(); // This should handle cleanup and submission
    }
}

function setupEventListeners() {
    // Handle tab visibility change (minimized, switched tabs)
    document.addEventListener('visibilitychange', function () {
        if (document.hidden) {
            tryAutoSubmitExam("Tab hidden or minimized");
        }
    });

    // Handle tab refresh or close
    window.addEventListener('beforeunload', function (e) {
        tryAutoSubmitExam("Page refresh or close");
        // Prevent default to show confirmation dialog (optional)
        e.preventDefault();
        e.returnValue = '';
    });

    let lastWindowSize = { width: window.innerWidth, height: window.innerHeight };

    window.addEventListener('resize', function () {
        const newWidth = window.innerWidth;
        const newHeight = window.innerHeight;

        // Detect significant change in window size (you can adjust the threshold)
        if (Math.abs(newWidth - lastWindowSize.width) > 100 || Math.abs(newHeight - lastWindowSize.height) > 100) {
            tryAutoSubmitExam("Window resized");
        }

        lastWindowSize = { width: newWidth, height: newHeight };
    });

    // Close result modal
    closeResultModalBtn.addEventListener('click', function() {
        resultModal.style.display = 'none';
    });

    // View results
    viewResultsBtn.addEventListener('click', function() {
        const examId = resultExamId.value.trim();
        if (examId) {
            showResults(examId);
        } else {
            alert('Please enter a valid Exam ID');
        }
    });

    // Tab switching
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const tabId = this.getAttribute('data-tab');
            switchTab(tabId);
        });
    });

    // Close modal buttons
    closeModalBtn.addEventListener('click', closeEditModal);
    cancelEditBtn.addEventListener('click', closeEditModal);
    window.addEventListener('click', function(event) {
        if (event.target === instructionsModal) {
            instructionsModal.style.display = 'none';
        }
        if (event.target === resultModal) {
            resultModal.style.display = 'none';
        }
    });

    // Send message
    sendMessageBtn.addEventListener('click', sendMessage);
    messageInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });
}

function switchTab(tabId) {
    // Update active tab button
    tabButtons.forEach(button => {
        button.classList.remove('active', 'bg-blue-100', 'text-blue-700');
        button.classList.add('hover:bg-gray-100');
    });
    document.querySelector(`.tab-btn[data-tab="${tabId}"]`).classList.add('active', 'bg-blue-100', 'text-blue-700');
    document.querySelector(`.tab-btn[data-tab="${tabId}"]`).classList.remove('hover:bg-gray-100');

    // Update active tab content
    tabContents.forEach(content => {
        content.classList.remove('active');
    });
    document.getElementById(tabId).classList.add('active');

    // Store the last active tab in localStorage
    localStorage.setItem('lastActiveTab', tabId);
}


// Initialize the page
document.addEventListener('DOMContentLoaded', function() {
    // Load admin list
    loadAdminList();

    // Set up event listeners
    setupEventListeners();
});

function loadAdminList() {
    adminList.innerHTML = '';
    
    admins.forEach(admin => {
        const adminBtn = document.createElement('button');
        adminBtn.className = 'w-full text-left py-2 px-3 rounded-lg hover:bg-gray-100';
        adminBtn.textContent = admin.name;
        adminBtn.addEventListener('click', function() {
            loadConversation(admin.id);
        });
        adminList.appendChild(adminBtn);
    });
}

function loadConversation(adminId) {
    currentAdminId = adminId;
    
    // Highlight selected admin
    const adminButtons = adminList.querySelectorAll('button');
    adminButtons.forEach(btn => {
        btn.classList.remove('bg-blue-100', 'text-blue-700');
    });
    event.target.classList.add('bg-blue-100', 'text-blue-700');
    
    // Load conversation
    const conversation = chatHistory[adminId] || [];
    conversationArea.innerHTML = '';
    
    if (conversation.length === 0) {
        conversationArea.innerHTML = '<p class="text-gray-500 text-center py-10">No messages yet. Start a conversation!</p>';
        return;
    }
    
    conversation.forEach(msg => {
        const isStudent = msg.sender === "STD2023001";
        const messageDiv = document.createElement('div');
        messageDiv.className = `chat-message ${isStudent ? 'sent-message' : 'received-message'}`;
        messageDiv.innerHTML = `
            <p>${msg.message}</p>
            <p class="text-xs ${isStudent ? 'text-blue-100' : 'text-gray-500'} mt-1">${formatTime(msg.time)}</p>
        `;
        conversationArea.appendChild(messageDiv);
    });
    
    // Scroll to bottom
    conversationArea.scrollTop = conversationArea.scrollHeight;
}

function sendMessage() {
    const message = messageInput.value.trim();
    if (!message || !currentAdminId) return;
    
    // In a real app, this would send the message to the server
    const newMessage = {
        sender: "STD2023001",
        message: message,
        time: new Date().toISOString()
    };
    
    if (!chatHistory[currentAdminId]) {
        chatHistory[currentAdminId] = [];
    }
    
    chatHistory[currentAdminId].push(newMessage);
    
    // Add to conversation area
    const messageDiv = document.createElement('div');
    messageDiv.className = 'chat-message sent-message';
    messageDiv.innerHTML = `
        <p>${message}</p>
        <p class="text-xs text-blue-100 mt-1">Just now</p>
    `;
    conversationArea.appendChild(messageDiv);
    
    // Clear input and scroll to bottom
    messageInput.value = '';
    conversationArea.scrollTop = conversationArea.scrollHeight;
}

function formatTime(isoString) {
    const date = new Date(isoString);
    return date.toLocaleString();
}