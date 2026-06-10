window.addEventListener("load", () => {
  const translations = {
    Note: "Nota",
    Tip: "Dica",
    Important: "Importante",
    Warning: "Atenção",
    Caution: "Cuidado",
  };

  document.querySelectorAll(".blockquote-tag-title").forEach((titleEl) => {
    // Itera sobre os "filhos" do título (o ícone <svg> e o texto)
    titleEl.childNodes.forEach((node) => {
      // Verifica se é apenas o nó de texto (ignora o <svg>)
      if (node.nodeType === Node.TEXT_NODE) {
        const text = node.textContent.trim();
        if (translations[text]) {
          node.textContent = translations[text];
        }
      }
    });
  });
});
