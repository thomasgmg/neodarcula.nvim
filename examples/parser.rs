use std::fs;
use std::error::Error;

// Represents a parsed line
#[derive(Debug)]
enum Token {
    Word(String),
    Number(i32),
}

struct Parser {
    contents: String,
}

impl Parser {
    fn new(filename: &str) -> Result<Self, Box<dyn Error>> {
        let contents = fs::read_to_string(filename)?;
        Ok(Parser { contents })
    }

    fn parse(&self) -> Vec<Token> {
        let mut tokens = Vec::new();
        for word in self.contents.split_whitespace() {
            if let Ok(num) = word.parse::<i32>() {
                tokens.push(Token::Number(num));
            } else {
                tokens.push(Token::Word(word.to_string()));
            }
        }
        tokens
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    let parser = Parser::new("input.txt")?;
    let tokens = parser.parse();
    for token in tokens {
        match token {
            Token::Word(w) => println!("Word: {}", w),
            Token::Number(n) => println!("Number: {}", n),
        }
    }
    Ok(())
}
