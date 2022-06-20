#![allow(dead_code)]

use std::cmp;

struct NavigationApi {
    entries: Vec<String>,
    index: usize
}

impl NavigationApi {
    fn get_page(&mut self) -> Option<String> {
        let entries_size = 0..self.entries.len();
        if entries_size.contains(&self.index) {
            Some(self.entries.get(self.index).unwrap().to_string())
        } else {
            None
        }
    }

    fn navigate(&mut self, path: &str) -> &mut Self {
        if self.entries.len() > 0 {
            self.index += 1;
        }
        self.entries.push(path.to_owned());
        self
    }

    fn previous_page(&mut self) -> &mut Self {
        if self.index > 0 { self.index -= 1; }
        self
    }

    fn next_page(&mut self) -> &mut Self {
        if self.index < self.entries.len() { self.index += 1; }
        self
    }

    fn get_recent_entries(self) -> Vec<String> {
        let number_of_recent_entries = cmp::min(self.entries.len(), 10);
        let starting_index = cmp::max(self.index - number_of_recent_entries, 0);
        self.entries[starting_index..self.index].to_vec()
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
    fn test_should_get_page() {
        let mut api = create_navigation_api();
        assert_eq!(api.get_page(), None);
    }
    
    #[test]
    fn test_should_navigate() {
        let mut api = create_navigation_api();
        api.navigate("/a");
        assert_eq!(api.get_page(), Some("/a".to_string()));
    }

    #[test]
    fn test_should_go_back_a_page() {
        let mut api = create_navigation_api();
        api.navigate("/a")
            .navigate("/b")
            .previous_page();
        assert_eq!(api.get_page(), Some("/a".to_string()));
    }

    #[test]
    fn test_should_go_next_a_page() {
        let mut api = create_navigation_api();
        api.navigate("/a")
            .navigate("/b")
            .navigate("/c")
            .previous_page()
            .previous_page()
            .next_page();
        assert_eq!(api.get_page(), Some("/b".to_string()));
    }

    #[test]
    fn test_should_return_the_last_ten_entries() {
        let mut api = create_navigation_api();

        for letter in 'a'..='z' {
            api.navigate(format!("/{}", letter).as_str());
        }

        // TODO: This is a workaround.
        api.next_page();
        let api_entries = api.get_recent_entries();
        assert_eq!(api_entries, ["/q", "/r", "/s", "/t", "/u", "/v", "/w", "/x", "/y", "/z"]);
    }    
}
