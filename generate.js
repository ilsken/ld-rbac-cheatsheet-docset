/* in chrome dev tools @ https://docs.launchdarkly.com/docs/actions-in-custom-roles */
/* this will copy some ruby code into your clipboard that you can pass to cheatset */
x = Array.from(Array.from(document.getElementById("content-container").querySelectorAll("div.magic-block-parameters ~ div")).reduce((blocks, elem) => {
  blocks[blocks.length - 1].push(elem);
  if (elem.matches('div.magic-block-parameters')) {
      blocks.push([]);
  }
  return blocks;
}, [
  []
]).filter(block => block.length).reduce((frag, block) => {
  var wrapper = document.createElement("section");
  block.forEach(elem => wrapper.appendChild(elem.cloneNode(true)));
  frag.appendChild(wrapper);
  return frag
}, document.createDocumentFragment()).querySelectorAll("section")).map(x => {
  return {
      description: (Array.from(x.querySelectorAll("div.magic-block-textarea > p")).map(x => x.matches('code') ? '\n' + x.innerText.replace("A code sample is below:", "") + '\n```\n' : x.innerHTML).join('\n')),
      url: x.querySelector('div.block-code-code code').innerText,
      title: x.querySelector("h3.header-scroll").innerText,
      short: x.querySelector("h3.header-scroll ~ p > code, div.magic-block-textarea code:first-child").innerText,
      commands: Array.from(x.querySelectorAll("div.block-parameters-table .tr")).map(row => row.querySelectorAll(".td")).filter(x => x.length).map(row => {
          return {
              action: row[0].innerText.trim(),
              description: row[1].innerText.trim()
          }
      }),
      x: x
  }
})
copy(x.map(x => {
  return {
      parent: x,
      entries: x.commands.map(cmd => `
  entry do
    command '${cmd.action}'   # Multiple commands are supported
    name '${cmd.action}'    # A short name, can contain Markdown or HTML
    notes <<-'END'
      ${cmd.description}

    END
  end 
`).join('\n')
  }
}).map(({
  parent,
  entries
}) => `
category do 
  id '${parent.title}'
  entry do
    command '${parent.short}'   # Multiple commands are supported
    command ${parent.url}
    name '${parent.short[0].toUpperCase()}${parent.short.substr(1)}s Resource'    # A short name, can contain Markdown or HTML
    notes <<-'END'
      ${parent.description.replace("'", "''")}

    END
  end
${entries}
end 
`).join('\n'))