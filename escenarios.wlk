import wollok.game.*
import bombero.*
import civiles_y_fuego.*
import fondos.*
import logros.*

class AdministradorDeNivel {
    var property objetosPendientes 

    method limpiarYReiniciar() {
        game.clear()
        menu.iniciar()
    }

    method perderJuego() {
        game.clear() //limpiamos todo el escenario
        game.addVisual(fondoGameOver) // mostramos el game over por derrota
        
   
        keyboard.space().onPressDo({ //con la tecla space volvemos al menu
            self.limpiarYReiniciar()
        })
    }
    method cumplirObjetivo() {
        objetosPendientes = objetosPendientes - 1

        if (objetosPendientes == 0) {
            game.say(bombero, "¡Misión Cumplida! Ganaste.")

            if (gestorDeNivel.nivelActual() == 1) { 
                menu.nivelDificilDesbloqueado(true) // se desbloquea el nivel dificil

                // -- podria agregar bombero.energia(0) para que se quede quieto el personaje.
                game.say(bombero, "¡Nivel 2 Desbloqueado! Volviendo al menú...")
                nivel1Completado.completar()
                
                game.schedule(2500, {
                    self.limpiarYReiniciar()
                })
            }
            if (gestorDeNivel.nivelActual() == 2) {
                game.say(bombero, "¡Ganaste el juego! Volviendo al menú...")
                nivel2Completado.completar()
                game.schedule(2500, {
                    self.limpiarYReiniciar()
                })
            }
        }
    }
}

const administradorDeNivel = new AdministradorDeNivel (objetosPendientes = 6)

object gestorDeNivel {
    var property nivelActual = 0
}

object menu {
    var property opcionSeleccionada = 1 
    var property nivelDificilDesbloqueado = false 
    const musicaDeFondo = game.sound("(GAME)hitslab-game-gaming-video-game-music-459876.mp3")
    var laMusicaSuena = false
    
    method iniciar() {
        
        self.opcionSeleccionada(1)

        musicaDeFondo.shouldLoop(true)
        musicaDeFondo.volume(0.5)
        if (!laMusicaSuena) {
            musicaDeFondo.play()
            laMusicaSuena = true
        }
        game.addVisual(fondoMenu)
        game.addVisual(titulo) 
        game.addVisual(cursorMenu) 
        game.addVisual(textoFacil) 
        game.addVisual(textoDificil)
        game.addVisual(textoControles)
        game.addVisual(trofeo)
        
        cursorMenu.position(game.at(3,7)) 

        keyboard.up().onPressDo { self.subir() }
        keyboard.down().onPressDo { self.bajar() }

        keyboard.w().onPressDo { self.subir() }
        keyboard.s().onPressDo { self.bajar() }

        keyboard.enter().onPressDo { self.seleccionar()} 

        keyboard.q().onPressDo { pestañaLogros.iniciar()} 
    }

    method subir() {
        if (opcionSeleccionada == 2) {
            opcionSeleccionada = 1
            cursorMenu.position(game.at(3,7)) 
        } else if (opcionSeleccionada == 3) {
            opcionSeleccionada = 2
            cursorMenu.position(game.at(3, 5)) 
        }
    }
    

    method bajar() {
        if (opcionSeleccionada == 1) {
            opcionSeleccionada = 2
            cursorMenu.position(game.at(3,5)) 
        } else if (opcionSeleccionada == 2) {
            opcionSeleccionada = 3
            cursorMenu.position(game.at(3, 3))
        }
    }

    method seleccionar() {
      
        if (not pestañaLogros.estaEnLogros()) {
            if (opcionSeleccionada == 1) {
                self.empezarJuegoFacil()
            } 
            else if (opcionSeleccionada == 2) {
                if (nivelDificilDesbloqueado) {
                    self.empezarJuegoDificil()
                } 
            } 
            else if (opcionSeleccionada == 3) {
                self.mostrarControles() 
            }
        }
    }
   
    method mostrarControles() {
        game.clear()
        game.addVisual(fondoControles) 

        keyboard.space().onPressDo({
            self.volverAlMenu()
        })
    }

    method empezarJuegoFacil() {
        game.clear()
        gestorDeNivel.nivelActual(1)
        administradorDeNivel.objetosPendientes(16)
        nivelFacil.iniciar()
    }

    method empezarJuegoDificil() {
        game.clear()
        gestorDeNivel.nivelActual(2)
        administradorDeNivel.objetosPendientes(14)
        nivelDificil.iniciar()
    }
    method volverAlMenu() {
        game.clear()
        self.iniciar()
    }

    method irALogros() {
        game.clear()
        pestañaLogros.iniciar()
    }
}


object nivelFacil {

    const posicionDeMuros = [game.at(0, 1), game.at(0, 2), game.at(0, 3), game.at(0, 4),
    game.at(0, 5), game.at(0, 6), game.at(0, 7), game.at(0, 8), game.at(0, 9), game.at(0, 10),
    game.at(0, 11), game.at(0, 12), game.at(0, 13), game.at(0, 14), game.at(0, 15),

    game.at(1, 0), game.at(1, 1), game.at(1, 2), game.at(1, 3), game.at(1, 4), game.at(1, 5),
    game.at(1, 6), game.at(1, 15),

    game.at(2, 0), game.at(2, 2), game.at(2, 3), game.at(2, 4), game.at(2, 5), game.at(2, 15),
    game.at(3, 0), game.at(3, 2), game.at(3, 3), game.at(3, 4), game.at(3, 5), game.at(3, 15),
    game.at(4, 0), game.at(4, 15),
    game.at(5, 0), game.at(5, 10), game.at(5, 15),
    game.at(6, 0), game.at(6, 9), game.at(6, 10), game.at(6, 15),
    game.at(7, 0), game.at(7, 15),
    game.at(8, 0), game.at(8, 15),
    game.at(9, 0), game.at(9, 7), game.at(9, 15),
    game.at(10, 0), game.at(10, 7), game.at(10, 9), game.at(10, 15),
    game.at(11, 0), game.at(11, 8), game.at(11, 9), game.at(11, 15),
    game.at(12, 0), game.at(12, 7), game.at(12, 12), game.at(12, 13), game.at(12, 15),
    game.at(13, 0), game.at(13, 1), game.at(13, 2), game.at(13, 12), game.at(13, 13), game.at(13, 15),
    game.at(14, 0), game.at(14, 1), game.at(14, 3), game.at(14, 7), game.at(14, 15),
    
    game.at(15, 0), game.at(15, 1), game.at(15, 2), game.at(15, 3), game.at(15, 4),
    game.at(15, 5), game.at(15, 6), game.at(15, 7), game.at(15, 8), game.at(15, 9), 
    game.at(15, 10), game.at(15, 11), game.at(15, 12), game.at(15, 13), game.at(15, 14), game.at(15, 15)]

    const civil1 = new Civil(position = game.at(2, 1), image = "civil2.png")
    const civil = new Civil(position = game.at(11, 1), image = "civil.png")
    const civil2 = new Civil(position = game.at(11, 4), image = "civil2.png")
    const civil3 = new Civil(position = game.at(11, 5), image = "civil2.png")
    const civil5 = new Civil(position = game.at(8, 11), image = "civil.png")

    const flama0 = new Fuego(position = game.at(2, 11), daño = 40)
    const flama1 = new Fuego(position = game.at(7, 11), daño = 40)
    const flama2 = new Fuego(position = game.at(8, 12), daño = 40)
    const flama3 = new Fuego(position = game.at(9, 13), daño = 40)
    const flama4 = new Fuego(position = game.at(13, 8), daño = 40)
    const flama5 = new Fuego(position = game.at(13, 7), daño = 40)
    const flama6 = new Fuego(position = game.at(10, 5), daño = 40)
    const flama7 = new Fuego(position = game.at(10, 4), daño = 40)
   

    const salida = new Salida(position = game.at(1, 12)) 

    const lago = new Lago(position = game.at(5,5))
    
    method iniciar() {
        posicionDeMuros.forEach({p => game.addVisual(new MuroInvisible(position = p))})
        game.addVisual(fondoNivel_1)
    
        bombero.prepararNivel(game.at(2, 12) , 300, 0)

        game.addVisual(energiaBombero)
        game.addVisual(cantidadDeAguaBombero)
        game.addVisual(civil2)
        game.addVisual(civil3)
        game.addVisual(civil5)
        game.addVisual(civil1)
        game.addVisual(civil)
        game.addVisual(lago)
        game.addVisual(flama0)
        game.addVisual(flama2)
        game.addVisual(flama1)
        game.addVisual(flama3)
        game.addVisual(flama4)
        game.addVisual(flama5)
        game.addVisual(flama6)
        game.addVisual(flama7)
        game.addVisual(bombero)
        game.addVisual(salida)

        keyboard.w().onPressDo({bombero.subir()})
        keyboard.s().onPressDo({bombero.bajar()})
        keyboard.d().onPressDo({bombero.derecha()})
        keyboard.a().onPressDo({bombero.izquierda()})

        keyboard.backspace().onPressDo({menu.volverAlMenu()})

        keyboard.up().onPressDo({bombero.subir()})
        keyboard.down().onPressDo({bombero.bajar()})
        keyboard.right().onPressDo({bombero.derecha()})
        keyboard.left().onPressDo({bombero.izquierda()})
        
        keyboard.p().onPressDo({ 
                console.println("game.addVisual(new Muro(position = game.at(" + bombero.position().x() + ", " + bombero.position().y() + ")))")
            })

        game.onCollideDo(bombero, {
            objeto => objeto.interactuarCon(bombero)
            })
        }
    }

object nivelDificil {
    
    const posicionDeMuros = [game.at(0,3), game.at(0,4), game.at(0,8), game.at(0,11), game.at(0,12), game.at(0,13),
                            game.at(1,1), game.at(1,2), game.at(1,5), game.at(1,7), game.at(1,9), game.at(1,10), game.at(1,14), 
                            game.at(2,0), game.at(2,5), game.at(2,7), game.at(2,14), 
                            game.at(3,0), game.at(3,5), game.at(3,6), game.at(3,7), game.at(3,10), game.at(3,15),
                            game.at(4,0), game.at(4,9), game.at(4,11), game.at(4,15), 
                            game.at(5,0), game.at(5,9), game.at(5,10), game.at(5,15),
                            game.at(6,0), game.at(6,14), game.at(6,15), 
                            game.at(7,0), game.at(7,9), game.at(7,10), game.at(7,14), game.at(7,15),
                            game.at(8,0), game.at(8,9), game.at(8,10), game.at(8,15), 
                            game.at(9,0), game.at(9,6), game.at(9,7), game.at(9,12), game.at(9,15),
                            game.at(10,0), game.at(10,6), game.at(10,7), game.at(10,9), game.at(10,10), game.at(10,11), game.at(10,13), game.at(10,14),
                            game.at(11,0), game.at(11,9), 
                            game.at(12,1), game.at(12,2), game.at(12,9), 
                            game.at(13,3), game.at(13,9),
                            game.at(14,3), game.at(14,9),
                            game.at(15,4), game.at(15,5), game.at(15,6), game.at(15,7), game.at(15,8)]

    const civil1 = new Civil(position = game.at(1, 12), image = "civil2.png")
    const civil2 = new Civil(position = game.at(1, 4), image = "civil.png")
    const civil3 = new Civil(position = game.at(8, 1), image = "civil.png")
    const civil4 = new Civil(position = game.at(9, 14), image = "civil2.png")
    const civil5 = new Civil(position = game.at(14, 7), image = "civil.png")

    const flama1 = new Fuego(position = game.at(1, 13), daño = 40)
    const flama2 = new Fuego(position = game.at(2, 4), daño = 40)
    const flama3 = new Fuego(position = game.at(2, 11), daño = 40)
    const flama4 = new Fuego(position = game.at(8, 2), daño = 40)
    const flama5 = new Fuego(position = game.at(8, 14), daño = 40)
    const flama6 = new Fuego(position = game.at(9, 13), daño = 40)
    const flama7 = new Fuego(position = game.at(13, 7), daño = 40)
    const flama8 = new Fuego(position = game.at(13, 8), daño = 40)
    const flama9 = new Fuego(position = game.at(14, 8), daño = 40)

    const salida = new Salida(position = game.at(4, 14))
    const lago = new Lago(position = game.at(5,5))
    
    method iniciar() {
        
        game.addVisual(fondoNivel_2)

        posicionDeMuros.forEach({p => game.addVisual(new MuroInvisible(position = p))})

        bombero.prepararNivel(game.at(3, 14) , 160, 0)

        game.addVisual(energiaBombero)
        game.addVisual(cantidadDeAguaBombero)
        game.addVisual(civil1)
        game.addVisual(civil2)
        game.addVisual(civil3)
        game.addVisual(civil4)
        game.addVisual(civil5)
        game.addVisual(flama1)
        game.addVisual(flama2)
        game.addVisual(flama3)
        game.addVisual(flama4)
        game.addVisual(flama5)
        game.addVisual(flama6)
        game.addVisual(flama7)
        game.addVisual(flama8)
        game.addVisual(flama9)
        game.addVisual(lago)
        game.addVisual(bombero)
        game.addVisual(salida)

        keyboard.w().onPressDo({bombero.subir()})
        keyboard.s().onPressDo({bombero.bajar()})
        keyboard.d().onPressDo({bombero.derecha()})
        keyboard.a().onPressDo({bombero.izquierda()})

        keyboard.up().onPressDo({bombero.subir()})
        keyboard.down().onPressDo({bombero.bajar()})
        keyboard.right().onPressDo({bombero.derecha()})
        keyboard.left().onPressDo({bombero.izquierda()})

        keyboard.backspace().onPressDo({menu.volverAlMenu()})

        keyboard.p().onPressDo({ 
                console.println("game.addVisual(new Muro(position = game.at(" + bombero.position().x() + ", " + bombero.position().y() + ")))")
            })
        
        game.onCollideDo(bombero, {
            objeto => objeto.interactuarCon(bombero)
            })
        }
}


class Menu {
    const property image
    var property position

}

const titulo = new Menu(image = "TituloMenuEscalado.png", position = game.at(4, 10))
const textoFacil = new Menu(image = "BotonFaciEscalado.png", position = game.at(4, 5))
const textoDificil = new Menu(image = "BotonDifiEscalado.png", position = game.at(4, 3))
const textoControles = new Menu(image = "controlesMenu.png", position = game.at(4, 1))
const cursorMenu = new Menu (image = "cursorEscalado.png",position = game.at(3, 7 ))






object pestañaLogros {
    var estaEnLogros = false
    method estaEnLogros() = estaEnLogros
    method cambiarEstaEnLogros(unbool) {
        estaEnLogros = unbool
    }
    const logro1 = new LogroNiveles(position = game.at(2, 13), nivelSeleccionado = nivel1Completado)
    const logro2 = new LogroNiveles(position = game.at(8, 13), nivelSeleccionado = nivel2Completado)
    const logro3 = new LogroRescates(position = game.at(2, 10), metaRescates = 3)
    const logro4 = new LogroRescates(position = game.at(8, 10), metaRescates = 20)
    const logro5 = new LogroIncendios(position = game.at(2, 7), metaApagar = 5)
    const logro6 = new LogroIncendios(position = game.at(8, 7), metaApagar = 15)
    

    method iniciar() {
        self.cambiarEstaEnLogros(true)
        game.addVisual(fondoLogros)

        game.addVisual(logro1)
        game.addVisual(logro2)
        game.addVisual(logro3)
        game.addVisual(logro4)
        game.addVisual(logro5)
        game.addVisual(logro6)

        keyboard.backspace().onPressDo({menu.volverAlMenu()})
        keyboard.backspace().onPressDo({self.cambiarEstaEnLogros(false)})
    }
    
}