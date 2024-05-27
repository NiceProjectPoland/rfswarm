# Este é o preâmbulo
Language: Portuguese

# Mais uma linha em branco

*** Comentários ***
This is a comments block
Second line of comments
Maybe this block is still in preamble

*** Definições ***
Biblioteca    Process
Recurso       full_pt.resource
Variável      full_pt.yaml
Variável      full_pt.json
Variável      full_pt.py

Documentação    This is the documentation
...    A continued line of documentation

Metadados    Nome    Value

Inicialização de Suíte      No Operation
Finalização de Suíte        No Operation

*** Variáveis ***
${myvar}    123

*** Comentários ***
This is a comments block
Second line of comments

*** Tarefas ***
Tarefa primeira
    [Documentação]    This is the documentation
    ...    A continued line of documentation
    [Inicialização]    Log To Console    Task Setup
    [Finalização]    Log To Console    Task Teardown
    [Tempo Limite]    60
    [Etiquetas]    first    second
    No Operation
    Primeira palavra-chave
    ${primeira}=    Verifica Lógica    'Ligado'
    ${segunda}=    Verifica Lógica    'Desativado'
    Log Variables
    Log    Tarefa executada com sucesso, primeira=${primeira}, segunda=${segunda}

Tarefa segunda
    [Modelo]    Primeira palavra-chave
    [Inicialização]    Log To Console    Task Setup
    [Finalização]    Log To Console    Task Teardown
    [Tempo Limite]    60
    [Etiquetas]    first    second
    No Operation
    Primeira palavra-chave
    Log To Console    Tarefa executada com sucesso

Tarefa terceira
    Dado "Sr. José" está registado
    E "carrinho" tem objectos
    Quando "Sr. José" clica em finalizar compra
    Então é apresentado o total e aguarda confirmação
    Mas é apresentado meio de pagamento indisponível

*** Palavras-Chave ***
Primeira palavra-chave
    [Documentação]    This is the documentation
    ...    A continued line of documentation
    [Argumentos]    @{arg}
    [Etiquetas]    first    second
    Log To Console    Esta é a primeira palavra-chave arg=${arg}

${utilizador} está registado
    No Operation

${carrinho de compras} tem objectos
    No Operation

${utilizador} clica em finalizar compra
    No Operation

é apresentado o total e aguarda confirmação
    No Operation

é apresentado meio de pagamento indisponível
    No Operation

