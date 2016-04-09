# Client Api Restul -  Swift
Uma simples classe desenvolvida com Swift 2.0 para facilitar o consumo de API Restful

###Aplicação

```swift
//Instâncio a classe
let api = requestApi()

//Declarando o endpoint e suas propriedades (path é obrigatório)
let endpoint = api.clientURLRequest("PATH", params: [], token:"TOKEN")

//Executando (GET, POST, PUT ou DELETE)      
api.post(endpoint){(success, object) -> () in
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        if success {
            print(object)
        } else {
            print(object)
        }
    })
}
```

