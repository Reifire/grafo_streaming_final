////////////////////////////////////////////////////////////////////////
// CONSTRAINTS
////////////////////////////////////////////////////////////////////////

CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT movie_id IF NOT EXISTS FOR (m:Movie) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT series_id IF NOT EXISTS FOR (s:Series) REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT genre_name IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;
CREATE CONSTRAINT actor_id IF NOT EXISTS FOR (a:Actor) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT director_id IF NOT EXISTS FOR (d:Director) REQUIRE d.id IS UNIQUE;

////////////////////////////////////////////////////////////////////////
// NODES – USERS (10)
////////////////////////////////////////////////////////////////////////

CREATE (:User {id: 1, name: "Ana"});
CREATE (:User {id: 2, name: "Bruno"});
CREATE (:User {id: 3, name: "Carlos"});
CREATE (:User {id: 4, name: "Diana"});
CREATE (:User {id: 5, name: "Eduardo"});
CREATE (:User {id: 6, name: "Fernanda"});
CREATE (:User {id: 7, name: "Gabriel"});
CREATE (:User {id: 8, name: "Helena"});
CREATE (:User {id: 9, name: "Igor"});
CREATE (:User {id: 10, name: "Julia"});

////////////////////////////////////////////////////////////////////////
// GENRES
////////////////////////////////////////////////////////////////////////

CREATE (:Genre {name: "Ação"});
CREATE (:Genre {name: "Drama"});
CREATE (:Genre {name: "Comédia"});
CREATE (:Genre {name: "Sci-Fi"});
CREATE (:Genre {name: "Terror"});

////////////////////////////////////////////////////////////////////////
// MOVIES (5)
////////////////////////////////////////////////////////////////////////

CREATE (:Movie {id: 101, title: "Matrix"});
CREATE (:Movie {id: 102, title: "Titanic"});
CREATE (:Movie {id: 103, title: "John Wick"});
CREATE (:Movie {id: 104, title: "Interestelar"});
CREATE (:Movie {id: 105, title: "Coringa"});

////////////////////////////////////////////////////////////////////////
// SERIES (5)
////////////////////////////////////////////////////////////////////////

CREATE (:Series {id: 201, title: "Breaking Bad"});
CREATE (:Series {id: 202, title: "Stranger Things"});
CREATE (:Series {id: 203, title: "The Office"});
CREATE (:Series {id: 204, title: "Dark"});
CREATE (:Series {id: 205, title: "Game of Thrones"});

////////////////////////////////////////////////////////////////////////
// ACTORS (5)
////////////////////////////////////////////////////////////////////////

CREATE (:Actor {id: 301, name: "Keanu Reeves"});
CREATE (:Actor {id: 302, name: "Leonardo DiCaprio"});
CREATE (:Actor {id: 303, name: "Bryan Cranston"});
CREATE (:Actor {id: 304, name: "Millie Bobby Brown"});
CREATE (:Actor {id: 305, name: "Joaquin Phoenix"});

////////////////////////////////////////////////////////////////////////
// DIRECTORS (5)
////////////////////////////////////////////////////////////////////////

CREATE (:Director {id: 401, name: "Wachowski Sisters"});
CREATE (:Director {id: 402, name: "James Cameron"});
CREATE (:Director {id: 403, name: "Christopher Nolan"});
CREATE (:Director {id: 404, name: "Todd Phillips"});
CREATE (:Director {id: 405, name: "Vince Gilligan"});

////////////////////////////////////////////////////////////////////////
// RELATIONSHIPS – MOVIES → GENRE
////////////////////////////////////////////////////////////////////////

MATCH (m:Movie {title:"Matrix"}), (g:Genre {name:"Sci-Fi"}) CREATE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {title:"Titanic"}), (g:Genre {name:"Drama"}) CREATE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {title:"John Wick"}), (g:Genre {name:"Ação"}) CREATE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {title:"Interestelar"}), (g:Genre {name:"Sci-Fi"}) CREATE (m)-[:IN_GENRE]->(g);
MATCH (m:Movie {title:"Coringa"}), (g:Genre {name:"Drama"}) CREATE (m)-[:IN_GENRE]->(g);

////////////////////////////////////////////////////////////////////////
// RELATIONSHIPS – SERIES → GENRE
////////////////////////////////////////////////////////////////////////

MATCH (s:Series {title:"Breaking Bad"}), (g:Genre {name:"Drama"}) CREATE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {title:"Stranger Things"}), (g:Genre {name:"Sci-Fi"}) CREATE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {title:"The Office"}), (g:Genre {name:"Comédia"}) CREATE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {title:"Dark"}), (g:Genre {name:"Sci-Fi"}) CREATE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {title:"Game of Thrones"}), (g:Genre {name:"Ação"}) CREATE (s)-[:IN_GENRE]->(g);

////////////////////////////////////////////////////////////////////////
// ACTORS IN MOVIES/SERIES
////////////////////////////////////////////////////////////////////////

MATCH (a:Actor {name:"Keanu Reeves"}), (m:Movie {title:"Matrix"}) CREATE (a)-[:ACTED_IN]->(m);
MATCH (a:Actor {name:"Leonardo DiCaprio"}), (m:Movie {title:"Titanic"}) CREATE (a)-[:ACTED_IN]->(m);
MATCH (a:Actor {name:"Bryan Cranston"}), (s:Series {title:"Breaking Bad"}) CREATE (a)-[:ACTED_IN]->(s);
MATCH (a:Actor {name:"Millie Bobby Brown"}), (s:Series {title:"Stranger Things"}) CREATE (a)-[:ACTED_IN]->(s);
MATCH (a:Actor {name:"Joaquin Phoenix"}), (m:Movie {title:"Coringa"}) CREATE (a)-[:ACTED_IN]->(m);

////////////////////////////////////////////////////////////////////////
// DIRECTORS
////////////////////////////////////////////////////////////////////////

MATCH (d:Director {name:"Wachowski Sisters"}), (m:Movie {title:"Matrix"}) CREATE (d)-[:DIRECTED]->(m);
MATCH (d:Director {name:"James Cameron"}), (m:Movie {title:"Titanic"}) CREATE (d)-[:DIRECTED]->(m);
MATCH (d:Director {name:"Christopher Nolan"}), (m:Movie {title:"Interestelar"}) CREATE (d)-[:DIRECTED]->(m);
MATCH (d:Director {name:"Todd Phillips"}), (m:Movie {title:"Coringa"}) CREATE (d)-[:DIRECTED]->(m);
MATCH (d:Director {name:"Vince Gilligan"}), (s:Series {title:"Breaking Bad"}) CREATE (d)-[:DIRECTED]->(s);

////////////////////////////////////////////////////////////////////////
// USERS WATCHED CONTENT (RANDOM RATINGS)
////////////////////////////////////////////////////////////////////////

MATCH (u:User {id:1}), (m:Movie {title:"Matrix"}) CREATE (u)-[:WATCHED {rating: 5}]->(m);
MATCH (u:User {id:1}), (s:Series {title:"Dark"}) CREATE (u)-[:WATCHED {rating: 4}]->(s);

MATCH (u:User {id:2}), (m:Movie {title:"John Wick"}) CREATE (u)-[:WATCHED {rating: 5}]->(m);
MATCH (u:User {id:2}), (s:Series {title:"Breaking Bad"}) CREATE (u)-[:WATCHED {rating: 4}]->(s);

MATCH (u:User {id:3}), (m:Movie {title:"Titanic"}) CREATE (u)-[:WATCHED {rating: 3}]->(m);
MATCH (u:User {id:3}), (s:Series {title:"The Office"}) CREATE (u)-[:WATCHED {rating: 5}]->(s);

MATCH (u:User {id:4}), (m:Movie {title:"Interestelar"}) CREATE (u)-[:WATCHED {rating: 5}]->(m);

MATCH (u:User {id:5}), (s:Series {title:"Game of Thrones"}) CREATE (u)-[:WATCHED {rating: 4}]->(s);

MATCH (u:User {id:6}), (m:Movie {title:"Coringa"}) CREATE (u)-[:WATCHED {rating: 5}]->(m);

MATCH (u:User {id:7}), (s:Series {title:"Stranger Things"}) CREATE (u)-[:WATCHED {rating: 4}]->(s);

MATCH (u:User {id:8}), (m:Movie {title:"Matrix"}) CREATE (u)-[:WATCHED {rating: 4}]->(m);

MATCH (u:User {id:9}), (s:Series {title:"Dark"}) CREATE (u)-[:WATCHED {rating: 5}]->(s);

MATCH (u:User {id:10}), (m:Movie {title:"Titanic"}) CREATE (u)-[:WATCHED {rating: 2}]->(m);
