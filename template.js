lol = require('./lol.json')
result = lol.map(({name, desc, actions, path}) => { return `
  category do
    id '${name}'
    entry do
      notes 'Resource'
    end
    entry do
      command '${path.split('/').slice(-2).shift().split(':').pop()}'   # Multiple commands are supported
      command '${path}'
      index_name 'Resource'
      extra_index_name '${name}'    # A short name, can contain Markdown or HTML
      notes <<-'END'
        ${desc}
      END
    end
    entry do
      notes 'Actions'
      index_name "Actions"
    end
`   + actions.map((val) => `
          
    entry do
      command '${Object.keys(val)[0]}'   # Multiple commands are supported
      notes <<-'END'
        ${Object.values(val)[0]}

      END
    end
`).join('\n')

});

console.log(result.join('\n  end\n'))
