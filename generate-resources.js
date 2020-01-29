copy(Array.from($0.querySelectorAll("div.tr")).map(x => x.querySelectorAll("div.td")).map(x => Array.from(x)).filter(x => x.length).map(x => { return { name: `${x[0].innerText[0].toUpperCase()}${x[0].innerText.substr(1)}s`, type: x[0].innerText, path: x[1].querySelectorAll("code")[1].innerText, doc: x[1].innerHTML }}).map(x => `
    entry do
      command '${x.type}'         # Optional
      command '${x.path}'   # Multiple commands are supported
      name '${x.name}'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        ${x.doc}
      END
    end
`).join('\n'))