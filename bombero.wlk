import escenarios.*
import civiles_y_fuego.*




object bombero {
    var property image = "bomberoPersonaje.png"
    var property position = game.at(1,0)
    var  agua = 0
    var  energia = 100
    var property estaCargandoUnCivil = false 
    var civilCargado = null


    method energia() = energia
    method agua() = agua

    method prepararNivel(nuevaPosicion, nuevaEnergia, cantAgua) {
        position = nuevaPosicion
        energia = nuevaEnergia
        agua = cantAgua
    }

    method cansarse() { // cada que movemos se cansa la energia baja en 1
        energia = (energia - 1).max(0)
        if (self.energia() == 0) {
            game.schedule(0, { game.stop() })
        }
    }

// tocar el fuego baja "cantidad" de energia. Lo decide la clase Fuego (aca podemos hacer que varie el "daño" dependiendo la dificultad)

    method quemarse(cantidad) {
        energia = (energia - cantidad).max(0)
        if (self.energia() == 0) {
            game.schedule(0, { game.stop() })
        }
    }

    method puedeIrA(nuevaPosicion) {
        const objetoEnPosicion = game.getObjectsIn(nuevaPosicion)

        return objetoEnPosicion.all({o => o.esAtravesable()})
    }
    method subir() {
        const proximo = position.up(1)

        if (self.puedeIrA(proximo)){
            position = proximo
        }
        
        self.cansarse()
    }
    method bajar() {
        const proximo = position.down(1)

        if (self.puedeIrA(proximo)){
            position = proximo
        }
        
        self.cansarse()
    }
    method derecha() {
        const proximo = position.right(1)

        if (self.puedeIrA(proximo)){
            position = proximo
        }
        
        self.cansarse()
    }
    method izquierda() {
        const proximo = position.left(1)

        if (self.puedeIrA(proximo)){
            position = proximo
        }
        
        self.cansarse()
    }

    method rescatar(civil) {
        if (estaCargandoUnCivil) {
            game.say(self, "Antes tengo que dejar al civil en un lugar seguro")
        } else {
            estaCargandoUnCivil = true
            civilCargado = civil
            image = "bomberoRescate.png"
            game.removeVisual(civil)
        }
    }
    method dejarCivilEnSalida() {
        estaCargandoUnCivil = false
        civilCargado.serSalvado()
        civilCargado = null
        image = "bomberoPersonaje.png"
    }

         
    method apagar(fuego){
    
        agua= agua-1
        self.cansarse()
        game.removeVisual(fuego)
        game.say(self, "Fuego apagado!")
    
    }


    method cargarAgua(){
        agua=3 //le puse como limite 3 pero podemos configurarlo a mas
        game.say(self, "Manguera cargada!")
    }
   


}

// cartel para visualizar la energia del personaje
object energiaBombero {
    const property position = game.at(1, 6)
    method text() = bombero.energia().toString()
    method textColor() = "FF0000FF"
    method interactuarCon(bombero) {}

    method esAtravesable() = false
}
// objeto agregado para que el bombero "deje" al civil y vuelva a su estado base
class Salida {
    var property position = game.at(1, 1)
    const property image = "salida.png"

    method interactuarCon(bombero) {
        if (bombero.estaCargandoUnCivil()) {
            bombero.dejarCivilEnSalida()
            game.say(bombero, "Un civil menos")
            administradorDeNivel1.cumplirObjetivo()
        }
    }

    method esAtravesable() = true
}