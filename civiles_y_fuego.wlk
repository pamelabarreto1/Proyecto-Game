import escenarios.*

class Elemento {
    
    method interactuarCon(bombero)
    method esAtravesable()

}

class Civil inherits Elemento{
    var property position
    const property image

    var estaASalvo = false

    method serSalvado() {
        estaASalvo = true
    }

    override method interactuarCon(bombero) {
        bombero.rescatar(self)
    }

    override method esAtravesable() = true
}

class Fuego inherits Elemento{
    const property position 
    const property image = "flama.png"
    var property daño = 20


    override method interactuarCon(bombero) {
        if(bombero.agua()>0){
            bombero.apagar(self)
        } else{
        bombero.quemarse(daño)
        game.say(bombero, "Auch, no tengo agua y me quemé!")
        if(bombero.energia() == 0) {
            game.say(bombero, "Sin energia para seguir")
        }
    }
}
    override method esAtravesable() = true
}


object lago inherits Elemento{
    const property position = game.at(5, 5) 
    const property image = "lago.png" 

    override method interactuarCon(bombero) {
        bombero.cargarAgua() 
    }
    
    override method esAtravesable() = true
}

class MuroInvisible inherits Elemento {
    const property image = "muroInvisible.png" //si quieren que el muro sea invisible, hay que sacarle el metodo image
    const property position

    override method interactuarCon(bombero) {}
    override method esAtravesable() = false
}