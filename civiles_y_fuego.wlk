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
    const property image 

    method interactuarCon(bombero) {
        
    }
}

