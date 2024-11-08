document.getElementById('competitionForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const title = document.getElementById('title').value;
    const category = document.getElementById('category').value;
    const content = document.getElementById('content').value;

    // 创建新的文章元素
    const articleDiv = document.createElement('div');
    articleDiv.innerHTML = `
      <h3>${title} - ${category}</h3>
      <p>${content}</p>
      <hr>
    `;

    // 将新文章添加到文章列表中
    document.getElementById('articles').appendChild(articleDiv);

    // 清空表单
    document.getElementById('competitionForm').reset();
});
