class Civil {
    var property position
    const property image

    method interactuarCon(bombero) {
        if (bombero.estaCargandoUnCivil()) {
            game.say(bombero, "Tengo que dejar el civil primero en la salida")
        }
        else {
            bombero.rescatar(self)
        }
    }
}

class Fuego {
    const property position 
    const property image = "flama.png"

    method interactuarCon(bombero) {
        if(bombero.agua()>0){
            bombero.apagar(self)
        } else{
        bombero.quemarse(20)
        game.say(bombero, "Auch, no tengo agua y me quemé!")
        if(bombero.energia() == 0) {
            game.say(bombero, "Sin energia para seguir")
        }
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
