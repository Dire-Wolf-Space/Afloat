//
//  RecipeBookExample.swift
//  Afloat
//
//  Created by Adélaïde Sky on 21/02/2026.
//
//  Copyright © 2026 Adélaïde. All rights reserved.
//  Licensed under the MIT License.
//

#if DEBUG

import SwiftUI

// MARK: - Example View

/// A recipe book app demonstrating Afloat's contextual navigation features.
///
/// This example shows how to create dynamic navigation titles and subtitles that update
/// as users scroll through different sections of content.
struct RecipeBookExample: View {
    let recipeCategories = RecipeCategory.sampleData
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(recipeCategories) { category in
                        Section {
                            ForEach(category.recipes) { recipe in
                                RecipeRow(recipe: recipe)
                            }
                        } header: {
                            CategoryHeader(category: category)
                        }
                    }
                }
            }
            // Enable contextual navigation with a default title
            .contextualNavigation(defaultTitle: "Recipe Book")
        }
    }
}

// MARK: - Category Header

struct CategoryHeader: View {
    let category: RecipeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(category.name)
                .font(.title2)
                .fontWeight(.bold)
                // The navigation title changes to this category name when scrolled past
                .navigationTitle(.contextual(hidesSourceView: true), category.name)
                // Show the recipe count as a subtitle in the navigation bar
                .navigationSubtitle(.contextual, "\(category.recipes.count) recipes")
            
            Text(category.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

// MARK: - Recipe Row

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 12) {
            // Leading emoji icon
            Text(recipe.icon)
                .font(.system(size: 44))
                .frame(width: 55)
            
            // Stacked info
            VStack(alignment: .leading, spacing: 2) {
                Text(recipe.name)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(recipe.shortDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                HStack(spacing: 12) {
                    Text("\(recipe.cookingTime) min")
                    Text("•")
                    Text("\(recipe.servings) servings")
                    Text("•")
                    Text(recipe.difficulty.rawValue)
                }
                .font(.caption2)
                .foregroundStyle(.tertiary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
}

// MARK: - Sample Data Models

struct RecipeCategory: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let recipes: [Recipe]
    
    static let sampleData: [RecipeCategory] = [
        RecipeCategory(
            name: "Breakfast",
            description: "Start your day with these delicious morning meals",
            recipes: [
                Recipe(
                    name: "Classic Pancakes",
                    shortDescription: "Fluffy buttermilk pancakes with maple syrup and fresh berries",
                    cookingTime: 20,
                    servings: 4,
                    difficulty: .easy,
                    cuisine: "American",
                    icon: "🥞"
                ),
                Recipe(
                    name: "Avocado Toast",
                    shortDescription: "Smashed avocado on sourdough with poached egg and chili flakes",
                    cookingTime: 10,
                    servings: 2,
                    difficulty: .easy,
                    cuisine: "Contemporary",
                    icon: "🥑"
                ),
                Recipe(
                    name: "French Toast",
                    shortDescription: "Golden brioche French toast with cinnamon and powdered sugar",
                    cookingTime: 15,
                    servings: 3,
                    difficulty: .easy,
                    cuisine: "French",
                    icon: "🍞"
                ),
                Recipe(
                    name: "Eggs Benedict",
                    shortDescription: "Poached eggs on English muffins with hollandaise sauce",
                    cookingTime: 25,
                    servings: 2,
                    difficulty: .medium,
                    cuisine: "American",
                    icon: "🥚"
                )
            ]
        ),
        RecipeCategory(
            name: "Lunch",
            description: "Satisfying midday meals for any occasion",
            recipes: [
                Recipe(
                    name: "Caesar Salad",
                    shortDescription: "Crisp romaine with creamy dressing, croutons, and parmesan",
                    cookingTime: 15,
                    servings: 2,
                    difficulty: .easy,
                    cuisine: "Italian",
                    icon: "🥗"
                ),
                Recipe(
                    name: "Grilled Cheese",
                    shortDescription: "Golden toasted sandwich with melted cheddar and tomato",
                    cookingTime: 10,
                    servings: 1,
                    difficulty: .easy,
                    cuisine: "American",
                    icon: "🧀"
                ),
                Recipe(
                    name: "Club Sandwich",
                    shortDescription: "Triple-decker with turkey, bacon, lettuce, and tomato",
                    cookingTime: 15,
                    servings: 2,
                    difficulty: .easy,
                    cuisine: "American",
                    icon: "🥪"
                ),
                Recipe(
                    name: "Chicken Wrap",
                    shortDescription: "Grilled chicken with vegetables and ranch in a soft tortilla",
                    cookingTime: 20,
                    servings: 2,
                    difficulty: .easy,
                    cuisine: "Contemporary",
                    icon: "🌯"
                )
            ]
        ),
        RecipeCategory(
            name: "Dinner",
            description: "Hearty evening dishes to end your day",
            recipes: [
                Recipe(
                    name: "Spaghetti Carbonara",
                    shortDescription: "Creamy pasta with pancetta, eggs, and aged parmesan cheese",
                    cookingTime: 25,
                    servings: 4,
                    difficulty: .medium,
                    cuisine: "Italian",
                    icon: "🍝"
                ),
                Recipe(
                    name: "Grilled Salmon",
                    shortDescription: "Fresh Atlantic salmon with lemon, herbs, and roasted vegetables",
                    cookingTime: 30,
                    servings: 2,
                    difficulty: .medium,
                    cuisine: "Contemporary",
                    icon: "🐟"
                ),
                Recipe(
                    name: "Margherita Pizza",
                    shortDescription: "Classic Italian pizza with fresh mozzarella, basil, and tomato",
                    cookingTime: 45,
                    servings: 4,
                    difficulty: .medium,
                    cuisine: "Italian",
                    icon: "🍕"
                ),
                Recipe(
                    name: "Chicken Tikka Masala",
                    shortDescription: "Tender chicken in a creamy tomato-based curry with basmati rice",
                    cookingTime: 50,
                    servings: 6,
                    difficulty: .medium,
                    cuisine: "Indian",
                    icon: "🍛"
                ),
                Recipe(
                    name: "Beef Stir Fry",
                    shortDescription: "Tender beef strips with colorful vegetables in savory sauce",
                    cookingTime: 35,
                    servings: 4,
                    difficulty: .medium,
                    cuisine: "Asian",
                    icon: "🥘"
                )
            ]
        ),
        RecipeCategory(
            name: "Desserts",
            description: "Sweet treats to satisfy your cravings",
            recipes: [
                Recipe(
                    name: "Chocolate Cake",
                    shortDescription: "Rich, moist chocolate layer cake with smooth chocolate ganache",
                    cookingTime: 60,
                    servings: 8,
                    difficulty: .hard,
                    cuisine: "French",
                    icon: "🍰"
                ),
                Recipe(
                    name: "Apple Pie",
                    shortDescription: "Classic homemade pie with cinnamon apples and flaky crust",
                    cookingTime: 90,
                    servings: 8,
                    difficulty: .medium,
                    cuisine: "American",
                    icon: "🥧"
                ),
                Recipe(
                    name: "Tiramisu",
                    shortDescription: "Italian coffee-flavored dessert with mascarpone and ladyfingers",
                    cookingTime: 30,
                    servings: 6,
                    difficulty: .medium,
                    cuisine: "Italian",
                    icon: "🍮"
                )
            ]
        )
    ]
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let shortDescription: String
    let cookingTime: Int
    let servings: Int
    let difficulty: Difficulty
    let cuisine: String
    let icon: String
    
    enum Difficulty: String {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
    }
}

// MARK: - Preview

#Preview {
    RecipeBookExample()
}

#endif
