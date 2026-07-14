import escenarios.*
import minijuegoTiming.*

class Elemento {
    
    method interactuarCon(bombero)
    method esAtravesable()

}

class Civil inherits Elemento{
    var property position
    const property image

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
        if (bombero.agua() > 0) {
            minijuegoTiming.iniciar(self)
        } 
        else {
            bombero.quemarse(daño)
            game.say(bombero, "Auch, no tengo agua y me quemé!")
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

    const property position

    override method interactuarCon(bombero) {}
    override method esAtravesable() = false
}