struct NavigationApi {
    entries: Vec<String>,
    index: usize
}

impl NavigationApi {
    fn get_page(&mut self) -> Option<String> {
        let entries_size = 0..self.entries.len();
        if entries_size.contains(&self.index) {
            Some(String::from(self.entries.get(self.index).unwrap()))
        } else {
            None
        }
    }

    fn navigate(&mut self, path: &str) {
        if self.entries.len() > 0 {
            self.index += 1;
        }
        self.entries.push(path.to_owned());
    }
}

fn create_navigation_api() -> NavigationApi {
    NavigationApi { entries: vec![], index: 0 }
}

fn main() {}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_should_navigate() {
        let mut api = create_navigation_api();
        api.navigate("/a");
        assert_eq!(api.get_page(), Some("/a".to_string()));
    }
}
