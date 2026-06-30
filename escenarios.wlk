import wollok.game.*
import bombero.*
import civiles_y_fuego.*
import fondos.*

object menu {
    method iniciar() {
        game.addVisual(fondoMenu)
        keyboard.f().onPressDo { self.empezarJuegoFacil() }
        keyboard.d().onPressDo { self.empezarJuegoDificil() }
    }
    method empezarJuegoFacil() {
        game.clear()
        nivelFacil.iniciar()
    }
    method empezarJuegoDificil() {
        game.clear()
        nivelDificil.iniciar()
    }
}
// ambos niveles son iguales, hay que cambiarlos.
object nivelFacil {

const civil1 = new Civil(position = game.at(3, 5), image = "civil2.png")
const civil = new Civil(position = game.at(5, 3), image = "civil.png")
const flama0 = new Fuego(position = game.at(1, 4))
const flama1 = new Fuego(position = game.at(3, 3))
const flama2 = new Fuego(position = game.at(5, 4))
const flama3 = new Fuego(position = game.at(2, 3))
    method iniciar() {

    game.addVisual(fondoNivel_1)
    
    game.addVisual(energiaBombero)
    game.addVisual(civil1)
    game.addVisual(civil)
    game.addVisual(lago)
    game.addVisual(flama0)
    game.addVisual(flama2)
    game.addVisual(flama1)
    game.addVisual(flama3)
    game.addVisual(bombero)
    game.addVisual(salida)

    keyboard.w().onPressDo({bombero.subir()})
    keyboard.s().onPressDo({bombero.bajar()})
    keyboard.d().onPressDo({bombero.derecha()})
    keyboard.a().onPressDo({bombero.izquierda()})
    

    game.onCollideDo(bombero, {
        objeto => objeto.interactuarCon(bombero)
        })
    }
}

object nivelDificil {

// Creamos los objetos a usar en el nivel
const civil1 = new Civil(position = game.at(3, 5), image = "civil2.png")
const civil = new Civil(position = game.at(5, 3), image = "civil.png")
const flama0 = new Fuego(position = game.at(2, 6), danio = 40)
    const flama1 = new Fuego(position = game.at(4, 2), danio = 40)//le agregué el danio a 40 para complejisar el juego
    const flama2 = new Fuego(position = game.at(6, 5), danio = 40)
    const flama3 = new Fuego(position = game.at(1, 1), danio = 40)

// iniciamos desde las opciones del menu

    method iniciar() {

// primero se agrega el fondo

    game.addVisual(fondoNivel_1)

    game.addVisual(energiaBombero)
    game.addVisual(civil1)
    game.addVisual(civil)
    game.addVisual(flama0)
    game.addVisual(flama2)
    game.addVisual(flama1)
    game.addVisual(flama3)
    game.addVisual(lago)
    game.addVisual(bombero)
    game.addVisual(salida)

    keyboard.w().onPressDo({bombero.subir()})
    keyboard.s().onPressDo({bombero.bajar()})
    keyboard.d().onPressDo({bombero.derecha()})
    keyboard.a().onPressDo({bombero.izquierda()})

    keyboard.up().onPressDo().apagarArriba()
    keyboard.right().onPressDo().apagarALaDerecha()
    keyboard.left().onPressDo().apagarALaIzquierda()
    keyboard.down().onPressDo().apagarAbajo()
    

    game.onCollideDo(bombero, {
        objeto => objeto.interactuarCon(bombero)
        })
    }
}