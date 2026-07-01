import escenarios.*
class Civil {
    var property position
    const property image

    var estaASalvo = false

    method serSalvado() {
        estaASalvo = true
    }

    method interactuarCon(bombero) {
        bombero.rescatar(self)
    }
}

class Fuego {
    const property position 
    const property image = "flama.png"
    var property danio= 20

    var estaApagado = false

    method serApagado() {
        estaApagado = true
        game.removeVisual(self)
    }

    method interactuarCon(bombero) {
        bombero.quemarse(danio)
        game.say(bombero, "Auch, no tengo agua y me quemé!")
        if(bombero.energia() == 0) {
            game.say(bombero, "Sin energia para seguir")

            administradorDeNivel1.cumplirObjetivo()
        }
    }
}


object lago {
    const property position = game.at(5, 5) 
    const property image = "lago.png" 

    method interactuarCon(bombero) {
        bombero.cargarAgua() 
    }
}
