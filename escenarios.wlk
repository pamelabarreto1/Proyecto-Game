import wollok.game.*
import bombero.*
import civiles_y_fuego.*
import fondos.*

class AdministradorDeNivel {
    var property objetosPendientes 

    method limpiarYReiniciar() {
        game.clear()
        menu.iniciar()
    }

    method cumplirObjetivo() {
        objetosPendientes = objetosPendientes - 1

        if (objetosPendientes == 0) {
            game.say(bombero, "¡Misión Cumplida! Ganaste.")

            if (gestorDeNivel.nivelActual() == 1) { 
                menu.nivelDificilDesbloqueado(true) // se desbloquea el nivel dificil

                // -- podria agregar bombero.energia(0) para que se quede quieto el personaje.
                game.say(bombero, "¡Nivel 2 Desbloqueado! Volviendo al menú...")
                
                game.schedule(2500, {
                    self.limpiarYReiniciar()
                })
            }
            if (gestorDeNivel.nivelActual() == 2) {
                game.say(bombero, "¡Ganaste el juego! Volviendo al menú...")
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
        //para evitar un bug que cuando se pierde en nivel dificil la opcionSeleccionada sea de nuevo facil.
        self.opcionSeleccionada(1)

        musicaDeFondo.shouldLoop(true)
        musicaDeFondo.volume(0.5)
        if (!laMusicaSuena) {
            musicaDeFondo.play()
            laMusicaSuena = true
        }
        game.addVisual(fondoMenu)
        game.addVisual(textoMenu) 
        game.addVisual(cursorMenu) 
        game.addVisual(textoFacil) //falta editar el menu para dejarlo mas lindo
        game.addVisual(textoDificil)
        
        cursorMenu.position(game.at(3,3)) // ubicado al lado del nivel facil.. le damos enter

        keyboard.up().onPressDo { self.subir() }
        keyboard.down().onPressDo { self.bajar() }

        keyboard.w().onPressDo { self.subir() }
        keyboard.s().onPressDo { self.bajar() }

        keyboard.enter().onPressDo { self.seleccionar()} //damos ENTER para arrancar el juego
    }

    method subir() {
        if (opcionSeleccionada == 2) {
            opcionSeleccionada = 1
            cursorMenu.position(game.at(3,3)) // sube el cursor
        }
    }

    method bajar() {
        if (opcionSeleccionada == 1) {
            opcionSeleccionada = 2
            cursorMenu.position(game.at(3,1)) //posicion en el nivel dificil
        }
    }

    method seleccionar() {
        if (opcionSeleccionada == 1) {
            self.empezarJuegoFacil()
        } else {
            
            if (nivelDificilDesbloqueado) {
                self.empezarJuegoDificil()
            } else {
                game.say(cursorMenu, "¡Superá el Nivel Fácil primero!")
            }
        }
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
}

// ambos niveles son iguales, hay que cambiarlos.
object nivelFacil {

    const posicionDeMuros = [game.at(0, 0), game.at(0, 1), game.at(0, 2), game.at(0,3), game.at(0, 4), game.at(0, 5), game.at(0, 6), game.at(0, 7), game.at(0, 8), game.at(0, 9)
    , game.at(0, 10), game.at(0, 11), game.at(0, 12), game.at(0, 13), game.at(0, 14), game.at(0, 15), game.at(1, 0), game.at(2, 0), game.at(3, 0), game.at(4, 0), game.at(5, 0),
    game.at(6, 0), game.at(7, 0), game.at(8, 0), game.at(9, 0), game.at(10, 0), game.at(11, 0), game.at(12, 0), game.at(13, 0), game.at(14, 0), game.at(15, 0),
    game.at(15, 1), game.at(15, 2), game.at(15, 3), game.at(15, 4), game.at(15, 5), game.at(15, 6), game.at(15, 7), game.at(15, 8), game.at(15, 9), game.at(15, 10), game.at(15, 11),
    game.at(15, 12), game.at(15, 13), game.at(15, 14), game.at(15, 15), game.at(1, 15), game.at(2, 15), game.at(3, 15), game.at(4, 15), game.at(5, 15), game.at(6, 15), game.at(7, 15),
    game.at(8, 15), game.at(9, 15), game.at(10, 15), game.at(11, 15), game.at(12, 15), game.at(13, 15), game.at(14, 15), game.at(1, 5), game.at(2, 5), game.at(1, 6), game.at(2, 6),
    game.at(1, 7), game.at(2, 7), game.at(11, 5), game.at(12, 5), game.at(13, 5), game.at(10, 10), game.at(8, 10),game.at(7, 10), game.at(12, 11), game.at(13, 13), game.at(14, 13),
    game.at(14, 14), game.at(13, 14), game.at(12, 14), game.at(14, 9), game.at(10, 13), game.at(9, 12)]
    const civil1 = new Civil(position = game.at(3, 5), image = "civil2.png")
    const civil = new Civil(position = game.at(5, 3), image = "civil.png")
    const civil2 = new Civil(position = game.at(1, 14), image = "civil2.png")
    const civil3 = new Civil(position = game.at(14, 1), image = "civil2.png")
    const civil4 = new Civil(position = game.at(12, 3), image = "civil.png")
    const civil5 = new Civil(position = game.at(14, 12), image = "civil.png")

    const flama0 = new Fuego(position = game.at(1, 4))
    const flama1 = new Fuego(position = game.at(3, 3))
    const flama2 = new Fuego(position = game.at(5, 4))
    const flama3 = new Fuego(position = game.at(2, 3))
    const flama4 = new Fuego(position = game.at(13, 12))
    const flama5 = new Fuego(position = game.at(14, 11))
    const flama6 = new Fuego(position = game.at(3, 14))
    const flama7 = new Fuego(position = game.at(2, 13))
    const flama8 = new Fuego(position = game.at(13, 2))
    const flama9 = new Fuego(position = game.at(10, 3))

    const salida = new Salida(position = game.at(1, 1)) // representa en que posicion esta la salida, sino no la reconoce

    method iniciar() {
        posicionDeMuros.forEach({p => game.addVisual(new MuroInvisible(position = p))})
        game.addVisual(fondoNivel_1)
    
        bombero.prepararNivel(game.at(2,1) , 200, 0)

        game.addVisual(energiaBombero)
        game.addVisual(civil2)
        game.addVisual(civil3)
        game.addVisual(civil4)
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
        game.addVisual(flama8)
        game.addVisual(flama9)
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
        
        game.onCollideDo(bombero, {
            objeto => objeto.interactuarCon(bombero)
            })
        }
    }

object nivelDificil {
    // Creamos los objetos a usar en el nivel
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

// iniciamos desde las opciones del menu
    method iniciar() {
        // primero se agrega el fondo
        game.addVisual(fondoNivel_2)

        posicionDeMuros.forEach({p => game.addVisual(new MuroInvisible(position = p))})

        bombero.prepararNivel(game.at(4, 14) , 160, 0)

        game.addVisual(energiaBombero)
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
object cursorMenu {
    var property position = game.at(0, 0)
    method image() = "cursorEscalado.png" 
}
object textoFacil {
    method image() = "BotonFaciEscalado.png"
    var property position = game.at(4,1)
    //method text() = "NIVEL FÁCIL"
    //method textColor() = "000000" // color negro en hexadecimal 
}
object textoDificil {
    method image() = "BotonDifiEscalado.png"
    var property position = game.at(4, -1) // ubicado abajo de la opción fácil
    //method text() = "NIVEL DIFÍCIL"
    //method textColor() = "000000" 
}
object textoMenu{
    method image() = "TituloMenuEscalado.png"
    var property position = game.at(0, 3)
}