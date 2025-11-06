import 'package:flutter/material.dart';
import 'book.dart';
import 'book_card.dart';
import 'book_detail.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // Estado de la pantalla.
  // Durante la clase analizaremos qué representa cada variable
  // y cuándo debe cambiar.
  bool isLoading = false;
  List<Book> books = [];
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  // Simula una operación asíncrona, como consultar una API.
  Future<List<Book>> loadBooks() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      Book(
        id: 1,
        title: 'El Principito',
        author: 'Antoine de Saint-Exupéry',
        price: 14.99,
        watched: true,
        description:
            'Un libro clásico que narra la historia de un joven príncipe que viaja a través del universo y aprende lecciones sobre la vida, la amistad y el amor.',
        imagepath: 'assets/images/el_principito.jpg',
      ),
      Book(
        id: 2,
        title: 'Cien años de soledad',
        author: 'Gabriel García Márquez',
        price: 22.50,
        watched: false,
        description:
            'Una novela que cuenta la historia de la familia Buendía a lo largo de varias generaciones en el pueblo ficticio de Macondo, explorando temas de amor, soledad y destino.',
        imagepath: 'assets/images/cien_anos_de_soledad.jpg',
      ),
      Book(
        id: 2,
        title: 'Don Quijote de la Mancha',
        author: 'Miguel de Cervantes',
        price: 18.00,
        watched: false,
        description:
            'La historia de un caballero que, acompañado de su fiel escudero Sancho Panza, se embarca en aventuras para revivir la caballería y luchar contra la injusticia.',
        imagepath: 'assets/images/don_quijote.jpg',
      ),
      Book(
        id: 3,
        title: 'Harry Potter y la piedra filosofal',
        author: 'J.K. Rowling',
        price: 19.99,
        watched: true,
        description:
            'El primer libro de la famosa saga de Harry Potter, donde un joven mago descubre su verdadera identidad y asiste a la escuela de magia Hogwarts.',
        imagepath: 'assets/images/harry_potter.jpg',
      ),
      Book(
        id: 4,
        title: 'El Señor de los Anillos',
        author: 'J.R.R. Tolkien',
        price: 25.00,
        watched: false,
        description:
            'Una épica historia de fantasía que sigue las aventuras de Frodo Bolsón y sus amigos mientras intentan destruir el Anillo Único y salvar la Tierra Media del mal.',
        imagepath: 'assets/images/el_senor_de_los_anillos.jpg',
      ),
      Book(
        id: 5,
        title: 'Crimen y castigo',
        author: 'Fiódor Dostoyevski',
        price: 16.50,
        watched: true,
        description:
            'Una novela psicológica que explora la mente de Raskólnikov, un joven estudiante que comete un asesinato y lucha con la culpa y la redención.',
        imagepath: 'assets/images/crimen_y_castigo.jpg',
      ),
      Book(
        id: 6,
        title: 'Orgullo y prejuicio',
        author: 'Jane Austen',
        price: 13.50,
        watched: false,
        description:
            'Una novela romántica que sigue la vida de Elizabeth Bennet y su relación con el orgulloso Sr. Darcy, explorando temas de amor, clase social y malentendidos.',
        imagepath: 'assets/images/orgullo_y_prejuicio.jpg',
      ),
      Book(
        id: 7,
        title: 'La Odisea',
        author: 'Homero',
        price: 15.00,
        watched: false,
        description:
            'La épica narrativa de la odisea de Ulises, un viaje lleno de desafíos y peligros que lo lleva a casa después de la guerra de Troya.',
        imagepath: 'assets/images/la_odisea.jpg',
      ),
      Book(
        id: 8,
        title: 'Los Juegos del Hambre',
        author: 'Suzanne Collins',
        price: 17.99,
        watched: true,
        description:
            'Una trilogía distópica que sigue a Katniss Everdeen mientras lucha por sobrevivir en un mundo donde los jóvenes son obligados a competir en juegos mortales transmitidos por televisión.',
        imagepath: 'assets/images/los_juegos_del_hambre.jpg',
      ),
    ];
  }

  // Esta función se construirá progresivamente durante la clase.
  Future<void> fetchBooks() async {
    // CHECKPOINTS DE LA CLASE:
    // 1. Activar el estado de carga.
    // 2. Esperar los datos.
    // 3. Guardar las películas.
    // 4. Finalizar la carga.
    // 5. Manejar un posible error.
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final data = await loadBooks();
      setState(() {
        books = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar los libros.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Películas')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Empezamos con una interfaz mínima que ya funciona.
    // Este método evolucionará durante los checkpoints.
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }
    if (books.isEmpty) {
      return Center(
        child: Column(
          children: [
            Text('No hay libros disponibles.'),
            ElevatedButton(
              onPressed: fetchBooks,
              child: const Text('Recargar libros'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          book: book,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetail(book: book)),
            );
          },
        );
      },
    );
  }
}
