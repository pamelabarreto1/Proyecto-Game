
object bombero {
    method imagen() = "bombero.png"

    var property position = game.origin()
    var property energia = 100

    method energia() = energia

    method subir() {
        position = position.up(1)
        energia = (energia - 1).max(0)
    }
    method bajar() {
        position = position.down(1)
        energia = (energia - 1).max(0)
    }
    method derecha() {
        position = position.right(1)
        energia = (energia - 1).max(0)
    }
    method izquierda() {
        position = position.left(1)
        energia = (energia - 1).max(0)
    }

    rescatar
    apagar
    cargarAgua
}